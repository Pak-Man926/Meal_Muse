# Meal Muse — Recipe API

A Django REST API powering the Meal Muse Flutter app. Provides Kenyan-focused recipe data sourced from Cookpad Kenya, the Afriyara Facebook page, and NYT Cooking — all stored in PostgreSQL with full-text search.

---

## Technology

| Layer | Stack |
|---|---|
| Language | Python 3 |
| Framework | Django 3 + Django REST Framework |
| Database | PostgreSQL (full-text search via `SearchVectorField`) |
| Scraping | `requests` + `BeautifulSoup4` (Cookpad) · `Selenium` (Facebook) |
| Serving | Gunicorn + Caddy (production) |

---

## Development Setup

**1. Start PostgreSQL:**
```bash
docker compose up -d postgres
```

**2. Install Python dependencies:**
```bash
pip install -r requirements.txt
```

**3. Run migrations and create tables:**
```bash
python manage.py migrate
python manage.py createcachetable
```

**4. Create admin superuser:**
```bash
python manage.py createsuperuser
```

**5. Seed the database with recipes:**
```bash
# NYT Cooking recipes (original source)
python manage.py scrape --urls --recipes

# Cookpad Kenya — all 18 Kenyan keywords
python manage.py scrape_cookpad

# Cookpad Kenya — single keyword test (faster)
python manage.py scrape_cookpad --keyword pilau --max-pages 2

# Afriyara Facebook page — opens Chrome (real window, good for first run)
python manage.py scrape_facebook --max-posts 5

# Afriyara Facebook page — headless, for production/server use
python manage.py scrape_facebook --headless --max-posts 100
```

**6. Start the dev server:**
```bash
DEBUG=1 python manage.py runserver
```
→ API available at `http://localhost:8000/api/`

---

## Deployment (Docker)

```bash
# Bring up everything (Caddy + Django + Postgres + scheduler)
docker compose up -d

# Deploy code update (front-end only)
git pull && docker compose up --force-recreate -d recipes

# Deploy with rebuild (front + back-end changes)
git pull && docker compose up --build --force-recreate -d recipes

# Force re-scrape all recipes manually in production
docker compose exec recipes python manage.py scrape --urls --recipes --force
docker compose exec recipes python manage.py scrape_cookpad --force
```

**Scheduled jobs run automatically via `deck-chores`:**

| Job | Frequency |
|---|---|
| Cookpad Kenya — new recipes | Weekly |
| Cookpad Kenya — force refresh | Every 30 days |
| Afriyara Facebook — new posts | Every 14 days |
| NYT Cooking — new recipes | Weekly |

---

## API Reference

**Base URL (dev):** `http://localhost:8000/api/`  
**Base URL (Android emulator):** `http://10.0.2.2:8000/api/`

All endpoints return JSON. No authentication required for reading.

---

### Recipes

#### List recipes
```
GET /api/recipe/
```

**Query parameters:**

| Parameter | Type | Example | Description |
|---|---|---|---|
| `search` | string | `search=ugali` | Full-text search across name, categories, ingredients |
| `category_name` | string | `category_name=pilau` | Filter by exact category name |
| `category_type` | string | `category_type=meal_types` | Filter by category type |
| `author` | string | `author=Afriyara` | Filter by source/author |
| `name__icontains` | string | `name__icontains=chicken` | Partial name match |
| `rating_value__gte` | int | `rating_value__gte=4` | Minimum star rating |
| `ordering` | string | `ordering=-rating_value` | Sort field (prefix `-` for descending) |
| `page` | int | `page=2` | Page number |
| `page_size` | int | `page_size=10` | Results per page (default 20, max 100) |

**Example calls:**
```
GET /api/recipe/?search=nyama choma
GET /api/recipe/?category_name=ugali&page_size=10
GET /api/recipe/?category_type=meal_types
GET /api/recipe/?ordering=-date_added&page_size=5
GET /api/recipe/?author=Afriyara
```

**Response envelope:**
```json
{
  "count": 142,
  "next": "http://localhost:8000/api/recipe/?page=2",
  "previous": null,
  "results": [
    {
      "id": 1,
      "name": "Kenyan Pilau",
      "slug": "cookpad-17237151",
      "image_path": "/static/recipes/cookpad-17237151.jpg",
      "description": "Aromatic Kenyan pilau with basmati rice and spices.",
      "total_time_string": "45 min",
      "servings": "Serves 4",
      "rating_value": 5,
      "rating_count": 12,
      "categories": [
        { "id": 3, "name": "pilau", "type": "dish_types" },
        { "id": 7, "name": "kenyan", "type": "cuisines" }
      ],
      "author": "Cookpad Kenya",
      "date_added": "2026-02-25",
      "search_rank": 0.0
    }
  ]
}
```

---

#### Get single recipe (full detail)
```
GET /api/recipe/<id>/
```

Returns everything from the list response **plus `ingredients` and `instructions` arrays:**
```json
{
  "id": 1,
  "name": "Kenyan Pilau",
  "slug": "cookpad-17237151",
  "image_path": "/static/recipes/cookpad-17237151.jpg",
  "description": "Aromatic Kenyan pilau...",
  "total_time_string": "45 min",
  "servings": "Serves 4",
  "rating_value": 5,
  "rating_count": 12,
  "ingredients": [
    "1 Kg Beef",
    "2 Cups Basmati Rice",
    "2 Medium onions, chopped",
    "1 Tsp Garlic paste",
    "1 Tbsp Garam masala"
  ],
  "instructions": [
    "Boil meat until tender.",
    "Soak rice in warm water for 10 minutes.",
    "Heat oil and fry onions until golden brown.",
    "Add garlic, ginger, and spices. Cook for 2 minutes.",
    "Add meat, rice, and 3 cups of water. Simmer on low heat."
  ],
  "categories": [
    { "id": 3, "name": "pilau", "type": "dish_types" }
  ],
  "author": "Cookpad Kenya",
  "date_added": "2026-02-25",
  "search_rank": 0.0
}
```

---

#### Trending recipes (home screen)
```
GET /api/recipe/trending/
GET /api/recipe/trending/?count=10
```

Returns the highest-rated recipes. Use this to populate the **Home screen carousel**.

| Parameter | Default | Description |
|---|---|---|
| `count` | 20 | Number of recipes to return (max 100) |

**Response:**
```json
{
  "count": 10,
  "results": [ /* RecipeListSerializer objects */ ]
}
```

---

#### Random recipes (discovery / inspire me)
```
GET /api/recipe/random/
GET /api/recipe/random/?count=5
```

Returns a random selection. Use for a **"What should I cook today?"** feature.

| Parameter | Default | Description |
|---|---|---|
| `count` | 5 | Number of recipes to return (max 20) |

---

### Categories

#### List all categories
```
GET /api/category/
```

Returns all categories in a **single flat list** (no pagination). Each includes `recipe_count` so the app can hide empty categories.

**Filter by type:**
```
GET /api/category/?type=meal_types
GET /api/category/?type=dish_types
GET /api/category/?type=cuisines
GET /api/category/?type=special_diets
```

**Response:**
```json
[
  { "id": 1, "name": "kenyan breakfast", "type": "meal_types", "recipe_count": 34 },
  { "id": 2, "name": "pilau",            "type": "dish_types", "recipe_count": 29 },
  { "id": 3, "name": "ugali",            "type": "dish_types", "recipe_count": 27 },
  { "id": 4, "name": "chapati",          "type": "dish_types", "recipe_count": 18 },
  { "id": 5, "name": "kenyan",           "type": "cuisines",   "recipe_count": 95 },
  { "id": 6, "name": "african",          "type": "cuisines",   "recipe_count": 42 }
]
```

---

### Scrape any external recipe URL
```
GET /api/just-the-recipe/?url=<recipe-url>
```

Fetches and parses a recipe from any supported site on the fly. Useful for a "paste a recipe URL" sharing feature.

```
GET /api/just-the-recipe/?url=https://www.allrecipes.com/recipe/12345/
```

---

## Kenyan Categories Reference

| Category Name | Type |
|---|---|
| `kenyan breakfast` | `meal_types` |
| `kenyan lunch` | `meal_types` |
| `kenyan dinner` | `meal_types` |
| `pilau` | `dish_types` |
| `ugali` | `dish_types` |
| `chapati` | `dish_types` |
| `nyama choma` | `dish_types` |
| `githeri` | `dish_types` |
| `mukimo` | `dish_types` |
| `sukuma wiki` | `dish_types` |
| `mandazi` | `dish_types` |
| `matumbo` | `dish_types` |
| `omena` | `dish_types` |
| `kachumbari` | `dish_types` |
| `maharagwe` | `dish_types` |
| `irio` | `dish_types` |
| `kenyan` | `cuisines` |
| `swahili` | `cuisines` |
| `african` | `cuisines` |
| `african street food` | `cuisines` |

---

## Helpers

**Clear API cache (shell):**
```bash
python manage.py shell
>>> from django.core.cache import cache
>>> cache.clear()
```

**Admin panel:** `http://localhost:8000/admin/`
