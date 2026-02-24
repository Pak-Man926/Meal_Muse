"""
Management command to scrape Kenya-focused recipes from Cookpad.

Usage:
    python manage.py scrape_cookpad                     # scrape all keywords
    python manage.py scrape_cookpad --keyword ugali     # single keyword
    python manage.py scrape_cookpad --force             # re-scrape existing
"""

import errno
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
from django.core.management.base import BaseCommand, CommandError

from recipe_api.settings import POSTGRES_LANGUAGE_UNACCENT
from recipes.models import Category, Recipe

logger = logging.getLogger(__name__)

# ──────────────────────────────────────────────
# Kenyan keyword → (category_name, category_type)
# ──────────────────────────────────────────────
KENYAN_KEYWORDS = {
    # meal_types
    "kenyan breakfast": ("kenyan breakfast", Category.TYPE_MEAL_TYPES),
    "kenyan lunch":     ("kenyan lunch",     Category.TYPE_MEAL_TYPES),
    "kenyan dinner":    ("kenyan dinner",    Category.TYPE_MEAL_TYPES),
    # dish_types — iconic Kenyan dishes
    "pilau":            ("pilau",            Category.TYPE_DISH_TYPES),
    "ugali":            ("ugali",            Category.TYPE_DISH_TYPES),
    "chapati":          ("chapati",          Category.TYPE_DISH_TYPES),
    "nyama choma":      ("nyama choma",      Category.TYPE_DISH_TYPES),
    "githeri":          ("githeri",          Category.TYPE_DISH_TYPES),
    "mukimo":           ("mukimo",           Category.TYPE_DISH_TYPES),
    "sukuma wiki":      ("sukuma wiki",      Category.TYPE_DISH_TYPES),
    "mandazi":          ("mandazi",          Category.TYPE_DISH_TYPES),
    "matumbo":          ("matumbo",          Category.TYPE_DISH_TYPES),
    "omena":            ("omena",            Category.TYPE_DISH_TYPES),
    "kachumbari":       ("kachumbari",       Category.TYPE_DISH_TYPES),
    "maharagwe":        ("maharagwe",        Category.TYPE_DISH_TYPES),
    "irio":             ("irio",             Category.TYPE_DISH_TYPES),
    # cuisines
    "kenyan":           ("kenyan",           Category.TYPE_CUISINES),
    "swahili":          ("swahili",          Category.TYPE_CUISINES),
    "african":          ("african",          Category.TYPE_CUISINES),
}

BASE_URL = "https://cookpad.com"
SEARCH_URL = "https://cookpad.com/ke/search/{keyword}?page={page}"
RECIPE_URL = "https://cookpad.com/eng/recipes/{recipe_id}"

IMAGE_DIR_NAME = "recipes"
STATIC_IMAGE_DIR = os.path.join(settings.STATIC_ROOT, IMAGE_DIR_NAME)

# Browser-like headers to reduce bot-blocking
HEADERS = {
    "User-Agent": (
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
        "AppleWebKit/537.36 (KHTML, like Gecko) "
        "Chrome/120.0.0.0 Safari/537.36"
    ),
    "Accept-Language": "en-US,en;q=0.9,sw;q=0.8",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    "Referer": "https://cookpad.com/ke",
}


class Command(BaseCommand):
    help = "Scrape Kenyan recipes from Cookpad (cookpad.com/ke)"

    force = False

    def add_arguments(self, parser):
        parser.add_argument(
            "--keyword",
            help="Scrape only this keyword (e.g. 'pilau'). Omit to scrape all.",
        )
        parser.add_argument(
            "--force",
            action="store_true",
            help="Re-scrape and update recipes that are already in the database.",
        )
        parser.add_argument(
            "--max-pages",
            type=int,
            default=10,
            help="Maximum search result pages to fetch per keyword (default 10).",
        )

    # ──────────────────────────────────────────
    # Entry point
    # ──────────────────────────────────────────
    def handle(self, *args, **options):
        self.force = options["force"]
        self._ensure_image_dir()

        keywords = KENYAN_KEYWORDS
        if options["keyword"]:
            kw = options["keyword"].lower()
            if kw not in keywords:
                raise CommandError(
                    f"Unknown keyword '{kw}'. "
                    f"Choose from: {', '.join(keywords.keys())}"
                )
            keywords = {kw: keywords[kw]}

        total_scraped = 0
        for keyword, (cat_name, cat_type) in keywords.items():
            self.stdout.write(self.style.MIGRATE_HEADING(f"\n▶ Keyword: {keyword}"))
            category = self._get_or_create_category(cat_name, cat_type)
            recipe_ids = self._collect_recipe_ids(keyword, options["max_pages"])
            self.stdout.write(f"  Found {len(recipe_ids)} recipe URLs")

            for recipe_id in recipe_ids:
                scraped = self._scrape_and_save(recipe_id, category)
                if scraped:
                    total_scraped += 1

        # Rebuild search vectors for all newly imported recipes
        if total_scraped > 0:
            self.stdout.write(self.style.MIGRATE_HEADING("\n▶ Building search vectors…"))
            self._update_search_vectors()

        # Clear API cache so fresh data is served
        cache.clear()
        self.stdout.write(
            self.style.SUCCESS(f"\n✔ Done — {total_scraped} recipes scraped/updated.")
        )

    # ──────────────────────────────────────────
    # Step 1 — collect recipe IDs from search
    # ──────────────────────────────────────────
    def _collect_recipe_ids(self, keyword: str, max_pages: int) -> list:
        """Return a deduplicated list of Cookpad recipe IDs for a keyword."""
        recipe_ids = set()
        encoded_keyword = keyword.replace(" ", "%20")

        for page in range(1, max_pages + 1):
            url = SEARCH_URL.format(keyword=encoded_keyword, page=page)
            try:
                resp = requests.get(url, headers=HEADERS, timeout=20)
            except requests.RequestException as e:
                self.stdout.write(self.style.WARNING(f"  Request error on {url}: {e}"))
                continue

            if resp.status_code != 200:
                self.stdout.write(
                    self.style.WARNING(f"  HTTP {resp.status_code} for {url}")
                )
                break

            soup = BeautifulSoup(resp.content, "html.parser")

            # Recipe links look like /eng/recipes/12345678 or /ke/recipes/12345678
            links = soup.find_all("a", href=re.compile(r"/recipes/\d+"))
            ids_on_page = set()
            for link in links:
                match = re.search(r"/recipes/(\d+)", link["href"])
                if match:
                    ids_on_page.add(match.group(1))

            if not ids_on_page:
                # No more results on this page
                break

            recipe_ids.update(ids_on_page)
            self.stdout.write(
                f"  Page {page}: {len(ids_on_page)} recipes "
                f"(total so far: {len(recipe_ids)})"
            )
            time.sleep(0.8)  # be polite

        return list(recipe_ids)

    # ──────────────────────────────────────────
    # Step 2 — scrape one recipe page
    # ──────────────────────────────────────────
    def _scrape_and_save(self, recipe_id: str, category: Category) -> bool:
        """Scrape a single Cookpad recipe and persist it. Returns True on success."""
        slug = f"cookpad-{recipe_id}"

        if not self.force and Recipe.objects.filter(slug=slug).exists():
            return False  # already imported, skip

        url = RECIPE_URL.format(recipe_id=recipe_id)
        try:
            resp = requests.get(url, headers=HEADERS, timeout=20)
        except requests.RequestException as e:
            self.stdout.write(self.style.WARNING(f"  Cannot fetch {url}: {e}"))
            return False

        if resp.status_code != 200:
            self.stdout.write(
                self.style.WARNING(f"  HTTP {resp.status_code} for {url}")
            )
            return False

        soup = BeautifulSoup(resp.content, "html.parser")

        # ── Name ──────────────────────────────
        name = self._extract_name(soup)
        if not name:
            logger.warning(f"Could not extract name from {url}")
            return False

        # ── Ingredients ───────────────────────
        ingredients = self._extract_ingredients(soup)
        if not ingredients:
            logger.warning(f"No ingredients found for {url}")
            return False

        # ── Instructions ──────────────────────
        instructions = self._extract_instructions(soup)

        # ── Metadata ──────────────────────────
        servings = self._extract_servings(soup)
        cook_time = self._extract_cook_time(soup)
        author = self._extract_author(soup)
        image_url = self._extract_image_url(soup)
        description = self._extract_description(soup)

        # ── Persist ───────────────────────────
        recipe, created = Recipe.objects.update_or_create(
            slug=slug,
            defaults=dict(
                name=name,
                description=description or f"A delicious {name} recipe from Cookpad Kenya.",
                total_time_string=cook_time,
                servings=servings or "Serves 4",
                ingredients=ingredients,
                instructions=instructions,
                author=author or "Cookpad Kenya",
            ),
        )
        recipe.categories.add(category)

        action = "Created" if created else "Updated"
        self.stdout.write(f"  {action}: {name}")

        # ── Download image ─────────────────────
        if image_url:
            try:
                self._download_image(recipe, image_url)
            except Exception as e:
                self.stdout.write(
                    self.style.WARNING(f"  Image download failed for {name}: {e}")
                )

        time.sleep(0.5)  # polite delay
        return True

    # ──────────────────────────────────────────
    # HTML extraction helpers
    # ──────────────────────────────────────────
    def _extract_name(self, soup: BeautifulSoup) -> str:
        """Extract recipe name from <h1> or OG title."""
        # Try h1 first
        h1 = soup.find("h1")
        if h1:
            return h1.get_text(strip=True)
        # Fallback to og:title
        og = soup.find("meta", property="og:title")
        if og:
            return og.get("content", "").strip()
        return ""

    def _extract_ingredients(self, soup: BeautifulSoup) -> list:
        """
        Extract ingredients list.
        Cookpad renders ingredients inside a section with id="ingredients"
        or inside <ul> tags with class patterns containing 'ingredient'.
        """
        # Strategy 1 — section#ingredients ul li
        section = soup.find(id="ingredients")
        if section:
            items = section.find_all("li")
            if items:
                return [li.get_text(" ", strip=True) for li in items if li.get_text(strip=True)]

        # Strategy 2 — any ul with 'ingredient' in class
        ul = soup.find("ul", class_=re.compile(r"ingredient", re.I))
        if ul:
            items = ul.find_all("li")
            if items:
                return [li.get_text(" ", strip=True) for li in items if li.get_text(strip=True)]

        # Strategy 3 — div with data-ingredient attribute
        divs = soup.find_all(attrs={"data-ingredient-id": True})
        if divs:
            return [d.get_text(" ", strip=True) for d in divs if d.get_text(strip=True)]

        # Strategy 4 — look for any element with "ingredients" in id/class
        for tag in soup.find_all(True):
            attrs = " ".join(str(v) for v in tag.attrs.values()).lower()
            if "ingredient" in attrs:
                items = tag.find_all("li")
                if items:
                    return [li.get_text(" ", strip=True) for li in items if li.get_text(strip=True)]

        return []

    def _extract_instructions(self, soup: BeautifulSoup) -> list:
        """
        Extract step-by-step instructions.
        Cookpad uses numbered li elements inside a steps section.
        """
        # Strategy 1 — section#steps li
        section = soup.find(id="steps")
        if section:
            items = section.find_all("li")
            if items:
                return [
                    li.get_text(" ", strip=True)
                    for li in items
                    if li.get_text(strip=True)
                ]

        # Strategy 2 — ol with 'step' in class
        ol = soup.find("ol", class_=re.compile(r"step", re.I))
        if ol:
            items = ol.find_all("li")
            if items:
                return [li.get_text(" ", strip=True) for li in items if li.get_text(strip=True)]

        # Strategy 3 — any div with data-step attribute
        steps = soup.find_all(attrs={"data-step": True})
        if steps:
            return [s.get_text(" ", strip=True) for s in steps if s.get_text(strip=True)]

        return []

    def _extract_image_url(self, soup: BeautifulSoup) -> str:
        """Extract main recipe image URL (prefer og:image)."""
        og = soup.find("meta", property="og:image")
        if og:
            return og.get("content", "")
        # Fallback: first large img
        for img in soup.find_all("img"):
            src = img.get("src", "")
            if src.startswith("http") and "recipe" in src.lower():
                return src
        return ""

    def _extract_description(self, soup: BeautifulSoup) -> str:
        """Extract OG description or recipe intro."""
        og = soup.find("meta", property="og:description")
        if og:
            return og.get("content", "").strip()
        og2 = soup.find("meta", attrs={"name": "description"})
        if og2:
            return og2.get("content", "").strip()
        return ""

    def _extract_servings(self, soup: BeautifulSoup) -> str:
        """Try to extract servings info."""
        # Cookpad often shows "Serves X" or "X servings" in a meta info area
        for tag in soup.find_all(True):
            text = tag.get_text(strip=True).lower()
            if re.search(r"\b(serves?|servings?|portions?)\b", text) and len(text) < 50:
                return tag.get_text(strip=True)
        return ""

    def _extract_cook_time(self, soup: BeautifulSoup) -> str:
        """Try to extract cook time info."""
        for tag in soup.find_all(True):
            text = tag.get_text(strip=True).lower()
            if re.search(r"\b(minutes?|mins?|hours?|hrs?)\b", text) and len(text) < 40:
                return tag.get_text(strip=True)
        return ""

    def _extract_author(self, soup: BeautifulSoup) -> str:
        """Extract recipe author name."""
        # Cookpad often puts author in a link: /ke/users/...
        link = soup.find("a", href=re.compile(r"/users/\d+"))
        if link:
            return link.get_text(strip=True)
        return "Cookpad Kenya"

    # ──────────────────────────────────────────
    # Image download  (mirrors NYT scraper logic)
    # ──────────────────────────────────────────
    def _download_image(self, recipe: Recipe, image_url: str):
        extension_match = re.match(r".*(\.\w{3,4})(\?.*)?$", os.path.basename(image_url))
        extension = extension_match.group(1) if extension_match else ".jpg"
        # Strip query params from extension if present
        extension = extension.split("?")[0]
        if not extension.startswith("."):
            extension = ".jpg"

        image_filename = f"{recipe.slug}{extension}"
        image_path = os.path.join(STATIC_IMAGE_DIR, image_filename)

        if not os.path.exists(image_path):
            resp = requests.get(image_url, stream=True, timeout=20, headers=HEADERS)
            resp.raise_for_status()
            with open(image_path, "wb") as f:
                shutil.copyfileobj(resp.raw, f)

        recipe.image_path = f"{settings.STATIC_URL}{IMAGE_DIR_NAME}/{image_filename}"
        recipe.save(update_fields=["image_path"])

    # ──────────────────────────────────────────
    # Category helper
    # ──────────────────────────────────────────
    def _get_or_create_category(self, name: str, cat_type: str) -> Category:
        category, created = Category.objects.get_or_create(
            name=name.lower(),
            defaults={"type": cat_type},
        )
        if created:
            self.stdout.write(f"  Created category: '{name}' [{cat_type}]")
        return category

    # ──────────────────────────────────────────
    # Search vector rebuild
    # ──────────────────────────────────────────
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

    # ──────────────────────────────────────────
    # Utility
    # ──────────────────────────────────────────
    def _ensure_image_dir(self):
        try:
            os.makedirs(STATIC_IMAGE_DIR)
        except OSError as e:
            if e.errno != errno.EEXIST:
                raise
