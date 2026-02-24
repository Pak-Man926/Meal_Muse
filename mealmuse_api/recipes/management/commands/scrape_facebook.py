"""
Management command to scrape recipes from the Afriyara Facebook page.

Uses Selenium (headless Chrome) to scroll through the public Facebook page,
extract posts that contain recipe-like text, and saves them as Recipe objects.

Usage:
    python manage.py scrape_facebook
    python manage.py scrape_facebook --max-posts 30
    python manage.py scrape_facebook --headless          # silent Chrome
    python manage.py scrape_facebook --force             # re-save existing
"""

import errno
import hashlib
import logging
import os
import re
import shutil
import time

import requests
from bs4 import BeautifulSoup
from django.conf import settings
from django.contrib.postgres.aggregates import StringAgg
from django.contrib.postgres.search import SearchVector
from django.core.cache import cache
from django.core.management.base import BaseCommand

from recipe_api.settings import POSTGRES_LANGUAGE_UNACCENT
from recipes.models import Category, Recipe

logger = logging.getLogger(__name__)

FACEBOOK_PAGE_URL = "https://www.facebook.com/Afriyara8/"
AUTHOR_NAME = "Afriyara"
IMAGE_DIR_NAME = "recipes"
STATIC_IMAGE_DIR = os.path.join(settings.STATIC_ROOT, IMAGE_DIR_NAME)

# Keywords that suggest a post contains a recipe
RECIPE_SIGNAL_WORDS = [
    "ingredients",
    "ingredient",
    "recipe",
    "how to make",
    "how to cook",
    "method",
    "instructions",
    "preparation",
    "directions",
    "steps",
]

# Section heading patterns used to split post text into fields
INGREDIENT_HEADINGS = re.compile(
    r"(?i)^(ingredients?|what you(\'ll)? need)\s*:?\s*$"
)
INSTRUCTION_HEADINGS = re.compile(
    r"(?i)^(instructions?|method|directions?|preparation|how to (make|cook|prepare)|steps?)\s*:?\s*$"
)


class Command(BaseCommand):
    help = "Scrape African/Kenyan recipes from the Afriyara Facebook page using Selenium."

    force = False

    def add_arguments(self, parser):
        parser.add_argument(
            "--max-posts",
            type=int,
            default=50,
            help="Maximum number of posts to process (default 50).",
        )
        parser.add_argument(
            "--headless",
            action="store_true",
            default=False,
            help="Run Chrome in headless mode (no visible browser window).",
        )
        parser.add_argument(
            "--force",
            action="store_true",
            help="Re-scrape and overwrite existing recipes.",
        )
        parser.add_argument(
            "--scroll-pause",
            type=float,
            default=3.0,
            help="Seconds to wait after each scroll (default 3).",
        )

    # ──────────────────────────────────────────
    # Entry point
    # ──────────────────────────────────────────
    def handle(self, *args, **options):
        self.force = options["force"]
        self._ensure_image_dir()

        # Import Selenium here so the management command can still be imported
        # on machines without selenium installed — it will only fail at runtime.
        try:
            from selenium import webdriver
            from selenium.webdriver.chrome.options import Options
            from selenium.webdriver.chrome.service import Service
            from selenium.webdriver.common.by import By
            from webdriver_manager.chrome import ChromeDriverManager
        except ImportError:
            self.stderr.write(
                self.style.ERROR(
                    "selenium and webdriver-manager are required. "
                    "Run: pip install selenium webdriver-manager"
                )
            )
            return

        # ── Set up Chrome ─────────────────────
        chrome_options = Options()
        if options["headless"]:
            chrome_options.add_argument("--headless=new")
        chrome_options.add_argument("--no-sandbox")
        chrome_options.add_argument("--disable-dev-shm-usage")
        chrome_options.add_argument("--disable-blink-features=AutomationControlled")
        chrome_options.add_argument("--window-size=1280,900")
        chrome_options.add_argument(
            "user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
            "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        )
        chrome_options.add_experimental_option("excludeSwitches", ["enable-automation"])
        chrome_options.add_experimental_option("useAutomationExtension", False)

        self.stdout.write(self.style.MIGRATE_HEADING("▶ Starting Chrome…"))
        driver = webdriver.Chrome(
            service=Service(ChromeDriverManager().install()),
            options=chrome_options,
        )
        driver.execute_script(
            "Object.defineProperty(navigator,'webdriver',{get:()=>undefined})"
        )

        try:
            posts_data = self._load_posts(
                driver,
                max_posts=options["max_posts"],
                scroll_pause=options["scroll_pause"],
            )
        finally:
            driver.quit()

        self.stdout.write(f"\n▶ Processing {len(posts_data)} posts…")
        saved = 0
        category = self._get_or_create_category()
        for post in posts_data:
            if self._save_post(post, category):
                saved += 1

        if saved > 0:
            self.stdout.write(self.style.MIGRATE_HEADING("\n▶ Building search vectors…"))
            self._update_search_vectors()

        cache.clear()
        self.stdout.write(
            self.style.SUCCESS(f"\n✔ Done — {saved} recipes saved from Afriyara page.")
        )

    # ──────────────────────────────────────────
    # Step 1 — load posts with Selenium
    # ──────────────────────────────────────────
    def _load_posts(self, driver, max_posts: int, scroll_pause: float) -> list:
        """
        Navigate to the Facebook page, scroll to load more posts, and
        extract raw post data (text + image URLs).
        """
        from selenium.webdriver.common.by import By

        self.stdout.write(f"  Opening {FACEBOOK_PAGE_URL}")
        driver.get(FACEBOOK_PAGE_URL)

        # Wait for page to settle after any interstitials
        time.sleep(5)

        # Dismiss cookie/login popup if present
        self._dismiss_popups(driver)

        posts_data = []
        last_height = driver.execute_script("return document.body.scrollHeight")
        scroll_attempts = 0
        max_scrolls = max_posts * 2  # rough upper bound

        self.stdout.write("  Scrolling page to load posts…")
        while len(posts_data) < max_posts and scroll_attempts < max_scrolls:
            # Parse current page state
            soup = BeautifulSoup(driver.page_source, "html.parser")
            posts_data = self._extract_raw_posts(soup)

            self.stdout.write(
                f"  Scroll #{scroll_attempts + 1}: "
                f"{len(posts_data)} posts found so far"
            )

            if len(posts_data) >= max_posts:
                break

            # Scroll down
            driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
            time.sleep(scroll_pause)
            new_height = driver.execute_script("return document.body.scrollHeight")

            if new_height == last_height:
                # No new content loaded
                scroll_attempts += 1
                if scroll_attempts >= 3:
                    self.stdout.write("  Reached bottom of page or no new content.")
                    break
            else:
                scroll_attempts = 0
                last_height = new_height

        return posts_data[:max_posts]

    def _dismiss_popups(self, driver):
        """
        Try to dismiss the Facebook login popup or cookie banner,
        which can obstruct content on public pages.
        """
        from selenium.webdriver.common.by import By

        # Common close / decline button patterns
        popup_selectors = [
            "[aria-label='Close']",
            "[data-testid='cookie-policy-manage-dialog-accept-button']",
            "button[title='Close']",
        ]
        for sel in popup_selectors:
            try:
                btn = driver.find_element(By.CSS_SELECTOR, sel)
                if btn.is_displayed():
                    btn.click()
                    time.sleep(1)
                    self.stdout.write(f"  Dismissed popup: {sel}")
                    break
            except Exception:
                pass

    # ──────────────────────────────────────────
    # Step 2 — extract raw post data from HTML
    # ──────────────────────────────────────────
    def _extract_raw_posts(self, soup: BeautifulSoup) -> list:
        """
        Parse the page HTML and return a list of dicts:
            {"text": str, "image_url": str | None}
        Only posts that look like they could be recipes are included.
        """
        posts = []
        seen_texts = set()

        # Facebook posts are in div elements with role="article"
        articles = soup.find_all("div", attrs={"role": "article"})

        for article in articles:
            # ── Extract post text ──────────────
            text_parts = []
            for elem in article.find_all(
                ["p", "span"], recursive=True
            ):
                t = elem.get_text(separator="\n", strip=True)
                if t:
                    text_parts.append(t)

            full_text = "\n".join(text_parts).strip()

            if not full_text:
                continue

            # Deduplicate
            text_hash = hashlib.md5(full_text[:200].encode()).hexdigest()
            if text_hash in seen_texts:
                continue
            seen_texts.add(text_hash)

            # Only keep posts that look like recipes
            if not self._looks_like_recipe(full_text):
                continue

            # ── Extract first image ────────────
            image_url = None
            img = article.find("img")
            if img:
                src = img.get("src", "")
                if src.startswith("http") and "static" not in src:
                    image_url = src

            posts.append({"text": full_text, "image_url": image_url})

        return posts

    def _looks_like_recipe(self, text: str) -> bool:
        """Return True if the post text likely contains a recipe."""
        text_lower = text.lower()
        return any(word in text_lower for word in RECIPE_SIGNAL_WORDS)

    # ──────────────────────────────────────────
    # Step 3 — parse post text → recipe fields
    # ──────────────────────────────────────────
    def _parse_recipe_from_text(self, text: str) -> dict | None:
        """
        Parse a post text into:
            name, description, ingredients (list), instructions (list)
        Returns None if we can't extract at least a name and ingredients.
        """
        lines = [l.strip() for l in text.splitlines() if l.strip()]
        if not lines:
            return None

        # ── Name: try first non-empty, non-heading line ──
        name = lines[0]
        if len(name) > 150 or INGREDIENT_HEADINGS.match(name) or INSTRUCTION_HEADINGS.match(name):
            # First line is too long or is itself a heading — try to infer a name
            match = re.search(r"\b(recipe for|how to make|how to cook)\s+(.+?)[\.\n]", text, re.I)
            name = match.group(2).strip() if match else "Afriyara Recipe"

        # ── Split into sections ──
        ingredients = []
        instructions = []
        description_lines = []

        mode = "desc"  # desc | ingredients | instructions
        for line in lines[1:]:
            if INGREDIENT_HEADINGS.match(line):
                mode = "ingredients"
                continue
            if INSTRUCTION_HEADINGS.match(line):
                mode = "instructions"
                continue

            # Auto-detect numbered/bulleted instruction lines
            if re.match(r"^(\d+[\.\)]\s|•\s|-\s)", line) and mode == "ingredients":
                mode = "instructions"

            if mode == "desc":
                description_lines.append(line)
            elif mode == "ingredients":
                # Clean up bullet/number prefixes
                cleaned = re.sub(r"^[\-•*\d]+[\.\)]\s*", "", line)
                if cleaned:
                    ingredients.append(cleaned)
            elif mode == "instructions":
                cleaned = re.sub(r"^[\-•*\d]+[\.\)]\s*", "", line)
                if cleaned:
                    instructions.append(cleaned)

        # ── Fallback: if no ingredients found, treat all lines as ingredients ──
        if not ingredients and len(lines) > 1:
            for line in lines[1:]:
                if not INGREDIENT_HEADINGS.match(line) and not INSTRUCTION_HEADINGS.match(line):
                    ingredients.append(re.sub(r"^[\-•*\d]+[\.\)]\s*", "", line))

        if not ingredients:
            return None

        description = " ".join(description_lines) or f"A delicious {name} from Afriyara."

        return {
            "name": name[:499],  # guard against CharField max_length
            "description": description[:2000],
            "ingredients": ingredients,
            "instructions": instructions if instructions else ["See full recipe on Afriyara Facebook page."],
        }

    # ──────────────────────────────────────────
    # Step 4 — persist one post to the DB
    # ──────────────────────────────────────────
    def _save_post(self, post: dict, category: Category) -> bool:
        parsed = self._parse_recipe_from_text(post["text"])
        if not parsed:
            return False

        # Generate a stable slug from the name
        slug = self._make_slug(parsed["name"])

        if not self.force and Recipe.objects.filter(slug=slug).exists():
            return False

        recipe, created = Recipe.objects.update_or_create(
            slug=slug,
            defaults=dict(
                name=parsed["name"],
                description=parsed["description"],
                total_time_string="",
                servings="Serves 4",
                ingredients=parsed["ingredients"],
                instructions=parsed["instructions"],
                author=AUTHOR_NAME,
            ),
        )
        recipe.categories.add(category)

        action = "Created" if created else "Updated"
        self.stdout.write(f"  {action}: {parsed['name']}")

        # Download image
        if post.get("image_url"):
            try:
                self._download_image(recipe, post["image_url"])
            except Exception as e:
                self.stdout.write(
                    self.style.WARNING(f"  Image download failed: {e}")
                )

        return True

    # ──────────────────────────────────────────
    # Helpers
    # ──────────────────────────────────────────
    def _make_slug(self, name: str) -> str:
        """Create a URL-safe slug from a recipe name."""
        slug = name.lower().strip()
        slug = re.sub(r"[^\w\s-]", "", slug)
        slug = re.sub(r"[\s_]+", "-", slug)
        slug = re.sub(r"-+", "-", slug).strip("-")
        slug = f"afriyara-{slug[:80]}"
        return slug

    def _get_or_create_category(self) -> Category:
        category, created = Category.objects.get_or_create(
            name="african street food",
            defaults={"type": Category.TYPE_CUISINES},
        )
        if created:
            self.stdout.write("  Created category: 'african street food' [cuisines]")
        # Also ensure the generic 'african' cuisine category exists
        Category.objects.get_or_create(
            name="african",
            defaults={"type": Category.TYPE_CUISINES},
        )
        return category

    def _download_image(self, recipe: Recipe, image_url: str):
        extension_match = re.match(r".*(\.\w{3,4})(\?.*)?$", image_url.split("?")[0])
        extension = extension_match.group(1) if extension_match else ".jpg"
        if not extension.startswith("."):
            extension = ".jpg"

        image_filename = f"{recipe.slug}{extension}"
        image_path = os.path.join(STATIC_IMAGE_DIR, image_filename)

        if not os.path.exists(image_path):
            headers = {
                "User-Agent": (
                    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                    "AppleWebKit/537.36 Chrome/120.0.0.0 Safari/537.36"
                )
            }
            resp = requests.get(image_url, stream=True, timeout=20, headers=headers)
            resp.raise_for_status()
            with open(image_path, "wb") as f:
                shutil.copyfileobj(resp.raw, f)

        recipe.image_path = f"{settings.STATIC_URL}{IMAGE_DIR_NAME}/{image_filename}"
        recipe.save(update_fields=["image_path"])

    def _update_search_vectors(self):
        vector = (
            SearchVector("name", weight="A", config=POSTGRES_LANGUAGE_UNACCENT)
            + SearchVector(
                StringAgg("categories__name", " "),
                weight="B",
                config=POSTGRES_LANGUAGE_UNACCENT,
            )
            + SearchVector(
                "ingredients", weight="C", config=POSTGRES_LANGUAGE_UNACCENT
            )
        )
        for recipe in Recipe.objects.annotate(vector=vector):
            recipe.search_vector = recipe.vector
            recipe.save(update_fields=["search_vector"])
        self.stdout.write(self.style.SUCCESS("  Search vectors updated."))

    def _ensure_image_dir(self):
        try:
            os.makedirs(STATIC_IMAGE_DIR)
        except OSError as e:
            if e.errno != errno.EEXIST:
                raise
