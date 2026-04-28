# MealMuse PHP API — Full Implementation Plan

Build a custom PHP API to power the MealMuse Flutter app, covering all 6 feature areas plus a web admin portal.

## Decisions Made (From Review)

- **Framework Choice**: Vanilla PHP with a lightweight router library (Slim-style).
- **Environment**: PHP and Composer are installed; we will verify the environment before running.
- **Authentication**: Starting with device UUID authentication. We will structure the database to allow for email/password authentication (proper auth) later.
- **Unit Conversion**: Server-side unit conversion. The API will convert metric to imperial on-the-fly based on user preferences to keep UI logic minimal.
- **Recipe Data Source**: Admin will add data manually for now. User uploads will be supported in the future.
- **Dietary Filtering**: Tag-based filtering for simplicity and effectiveness.

## Proposed Architecture

```text
mealmuse_php/
├── public/                    # Web root (entry point)
│   ├── index.php              # API router entry point
│   ├── admin/                 # Admin portal (web UI)
│   │   ├── index.php
│   │   ├── assets/            # CSS, JS for admin
│   │   └── ...
│   └── uploads/               # Recipe images
├── src/
│   ├── Config/
│   │   ├── Database.php       # MySQL connection (PDO)
│   │   └── Config.php         # App constants, env vars
│   ├── Models/
│   │   ├── Recipe.php
│   │   ├── Category.php
│   │   ├── User.php
│   │   ├── Schedule.php
│   │   ├── Favourite.php
│   │   ├── UserSettings.php
│   │   └── AuditLog.php
│   ├── Controllers/
│   │   ├── RecipeController.php
│   │   ├── CategoryController.php
│   │   ├── SearchController.php
│   │   ├── ScheduleController.php
│   │   ├── FavouriteController.php
│   │   ├── SettingsController.php
│   │   ├── TrendingController.php
│   │   └── Admin/
│   │       ├── DashboardController.php
│   │       ├── RecipeAdminController.php
│   │       ├── UserAdminController.php
│   │       └── AuditLogController.php
│   ├── Middleware/
│   │   ├── AuthMiddleware.php      # Device/user authentication
│   │   ├── CorsMiddleware.php      # Cross-origin for Flutter
│   │   └── AdminAuthMiddleware.php # Admin login guard
│   ├── Helpers/
│   │   ├── Response.php        # JSON response builder
│   │   ├── Validator.php       # Input validation
│   │   ├── Paginator.php       # Pagination helper
│   │   ├── UnitConverter.php   # Metric ↔ Imperial
│   │   └── ImageCompressor.php # Compresses uploaded images
│   └── Routes/
│       ├── api.php             # All API routes
│       └── admin.php           # Admin web routes
├── migrations/                 # SQL migration files
│   ├── 001_create_categories.sql
│   ├── 002_create_recipes.sql
│   ├── 003_create_users.sql
│   ├── 004_create_schedules.sql
│   ├── 005_create_favourites.sql
│   ├── 006_create_user_settings.sql
│   └── 007_create_audit_logs.sql
├── admin_templates/            # Admin portal HTML templates
│   ├── layout.php
│   ├── login.php
│   ├── dashboard.php
│   ├── recipes/
│   ├── users/
│   └── audit_logs/
├── scripts/
│   └── migrate.php             # Run migrations
├── README.md                   # API details, how to run, and hosting guide
├── composer.json
├── .env
├── .env.example
└── .htaccess
```

---

## Database Schema Design

### Table: `categories`
| Column | Type | Constraints |
|--------|------|-------------|
| `id` | INT AUTO_INCREMENT | PRIMARY KEY |
| `name` | VARCHAR(100) | UNIQUE, NOT NULL |
| `meal_type` | ENUM('breakfast', 'lunch', 'dinner', 'drinks', 'desserts', 'soups', 'snacks', 'baked_foods') | NOT NULL |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

### Table: `recipes`
| Column | Type | Constraints |
|--------|------|-------------|
| `id` | INT AUTO_INCREMENT | PRIMARY KEY |
| `name` | VARCHAR(500) | NOT NULL |
| `slug` | VARCHAR(200) | UNIQUE, NOT NULL |
| `images` | JSON | DEFAULT '[]' — Links to compressed images |
| `description` | TEXT | |
| `total_time` | INT | NULLABLE |
| `servings` | VARCHAR(100) | |
| `rating_value` | INT | NULLABLE |
| `rating_count` | INT | NULLABLE |
| `ingredients` | JSON | NOT NULL |
| `instructions` | JSON | NOT NULL |
| `author` | VARCHAR(100) | |
| `dietary_tags` | JSON | DEFAULT '[]' — e.g. ["vegan","gluten_free"] |
| `nutrition_info` | JSON | NULLABLE — calories, protein, etc. |
| `date_added` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

**Note on Images**: The system will allow uploading multiple images. During upload, they will be compressed to save storage, and only their public links/paths will be saved in the `images` JSON array.

**Indexes**: FULLTEXT on `name, description` for search. INDEX on `slug`, `rating_value`.

### Table: `recipe_categories` (pivot)
| Column | Type | Constraints |
|--------|------|-------------|
| `recipe_id` | INT | FK → recipes.id ON DELETE CASCADE |
| `category_id` | INT | FK → categories.id ON DELETE CASCADE |
| | | PRIMARY KEY (recipe_id, category_id) |

### Table: `users`
| Column | Type | Constraints |
|--------|------|-------------|
| `id` | INT AUTO_INCREMENT | PRIMARY KEY |
| `device_uuid` | VARCHAR(255) | UNIQUE, NOT NULL |
| `email` | VARCHAR(255) | NULLABLE, UNIQUE |
| `first_name` | VARCHAR(100) | NULLABLE |
| `last_name` | VARCHAR(100) | NULLABLE |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| `last_active_at` | TIMESTAMP | NULLABLE |

### Table: `user_settings`
| Column | Type | Constraints |
|--------|------|-------------|
| `id` | INT AUTO_INCREMENT | PRIMARY KEY |
| `user_id` | INT | FK → users.id, UNIQUE |
| `unit_system` | ENUM('metric','imperial') | DEFAULT 'metric' |
| `dietary_restrictions` | JSON | DEFAULT '[]' — ["vegan","gluten_free","dairy_free","vegetarian"] |
| `recipe_recommendations` | BOOLEAN | DEFAULT TRUE |
| `updated_at` | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP |

### Table: `schedules`
| Column | Type | Constraints |
|--------|------|-------------|
| `id` | INT AUTO_INCREMENT | PRIMARY KEY |
| `user_id` | INT | FK → users.id |
| `recipe_id` | INT | FK → recipes.id |
| `day_of_week` | ENUM('sunday','monday','tuesday','wednesday','thursday','friday','saturday') | NOT NULL |
| `meal_type` | ENUM('breakfast', 'lunch', 'dinner', 'drinks', 'desserts', 'soups', 'snacks', 'baked_foods') | NOT NULL |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| | | UNIQUE (user_id, day_of_week, meal_type) |

### Table: `favourites`
| Column | Type | Constraints |
|--------|------|-------------|
| `id` | INT AUTO_INCREMENT | PRIMARY KEY |
| `user_id` | INT | FK → users.id |
| `recipe_id` | INT | FK → recipes.id |
| `meal_type` | ENUM('breakfast', 'lunch', 'dinner', 'drinks', 'desserts', 'soups', 'snacks', 'baked_foods') | NULLABLE |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| | | UNIQUE (user_id, recipe_id) |

### Table: `audit_logs`
| Column | Type | Constraints |
|--------|------|-------------|
| `id` | INT AUTO_INCREMENT | PRIMARY KEY |
| `actor` | VARCHAR(100) | NOT NULL — 'admin', 'system', or user identifier |
| `action` | VARCHAR(50) | NOT NULL — 'create', 'update', 'delete', 'login', 'error' |
| `entity_type` | VARCHAR(50) | NOT NULL — 'recipe', 'category', 'user', 'settings', 'admin_user' |
| `entity_id` | INT | NULLABLE |
| `payload` | JSON | NULLABLE — The request payload/data |
| `response` | JSON | NULLABLE — The response or error details |
| `details` | JSON | NULLABLE — old/new values, metadata |
| `ip_address` | VARCHAR(45) | NULLABLE |
| `status` | ENUM('success', 'failure') | DEFAULT 'success' |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

**Index**: INDEX on `entity_type, action`, INDEX on `created_at`.

### Table: `admin_users`
| Column | Type | Constraints |
|--------|------|-------------|
| `id` | INT AUTO_INCREMENT | PRIMARY KEY |
| `username` | VARCHAR(50) | UNIQUE, NOT NULL |
| `password_hash` | VARCHAR(255) | NOT NULL |
| `email` | VARCHAR(255) | UNIQUE |
| `first_name` | VARCHAR(100) | NOT NULL |
| `last_name` | VARCHAR(100) | NOT NULL |
| `role` | ENUM('super_admin','admin','viewer') | DEFAULT 'admin' |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| `last_login` | TIMESTAMP | NULLABLE |

---

## API Endpoints

### 1. Homepage — Categories & Trending

```
GET /api/categories
  → Returns all categories
  → Query: ?meal_type=breakfast
  → Response: [{ id, name, meal_type, recipe_count }]

GET /api/recipes/trending
  → Returns 5 random recipes (refreshes each call), auto-converts units based on headers.
  → Response: { count: 5, results: [{ id, name, slug, images, description, total_time, servings, rating_value, categories }] }
```

### 2. Search Page

```
GET /api/recipes
  → List/search recipes (lightweight — no ingredients/instructions)
  → Query params:
    ?search=chicken           — FULLTEXT search on name + description
    ?category=breakfast       — filter by category name
    ?category_id=3            — filter by category ID
    ?dietary=vegan,gluten_free — filter by dietary tags
    ?max_time=30              — quick recipes (total_time <= 30)
    ?page=1&per_page=20       — pagination
    ?sort=rating_value&order=desc
  → Response: { count, page, per_page, total_pages, results: [...] }

GET /api/recipes/{id}
  → Full recipe detail (with ingredients + instructions)
  → Response: { id, name, slug, images, description, total_time, servings, rating_value, rating_count, ingredients, instructions, categories, author, dietary_tags, date_added }
```

### 3. Schedule Page

```
GET /api/users/{user_id}/schedule
  → Returns all 7 days of scheduled meals
  → Response: { sunday: [{ id, recipe_id, recipe: {...}, meal_type }], monday: [...], ... }

POST /api/users/{user_id}/schedule
  → Add a meal to schedule
  → Body: { recipe_id, day_of_week, meal_type }
  → Replaces existing if same day + meal_type combo exists

DELETE /api/users/{user_id}/schedule/{schedule_id}
  → Remove a meal from schedule
```

### 4. Saved/Favourites

```
GET /api/users/{user_id}/favourites
  → List all favourites
  → Query: ?meal_type=breakfast — filter by meal type
  → Response: { count, results: [{ id, recipe: {...}, meal_type, created_at }] }

POST /api/users/{user_id}/favourites
  → Add a favourite
  → Body: { recipe_id, meal_type }

DELETE /api/users/{user_id}/favourites/{recipe_id}
  → Remove a favourite
```

### 5. Settings

```
GET /api/users/{user_id}/settings
  → Get user preferences
  → Response: { unit_system, dietary_restrictions, recipe_recommendations }

PUT /api/users/{user_id}/settings
  → Update preferences
  → Body: { unit_system: "imperial", dietary_restrictions: ["vegan"], ... }

POST /api/users/register
  → Register device (auto-creates user + default settings)
  → Body: { device_uuid }
  → Response: { user_id, device_uuid }
```

### 6. Admin Portal (Web UI)

The admin portal is a **server-rendered** web interface (PHP + HTML/CSS/JS), NOT a separate SPA. Accessible at `/admin/`.

**Admin Features & Roles:**
- **Super Admin**: Can manage all entities, including creating/deleting other admins and viewing Audit Logs.
- **Admin**: Can manage recipes, categories, and regular users. **Cannot** create other admins or view Audit Logs.

| Section | Capabilities |
|---------|-------------|
| **Dashboard** | Total recipes, total users, recent activity graph, quick stats |
| **Recipes** | View all (paginated, searchable), add new (multiple image upload & compression), edit, delete. |
| **Categories** | View, add, edit, delete |
| **Users** | View list (after 200+ users, start collecting data). See user activity. |
| **Audit Logs** | (Super Admin Only) Searchable, filterable log of all CRUD operations including request payloads, responses, and errors. |
| **Settings** | Admin account management |

---

## Proposed Changes Checklist

- [ ] Create `README.md` with setup and hosting documentation.
- [ ] Initialize PHP/Composer project (`composer.json`) with `bramus/router`, `phpdotenv`, `php-jwt`.
- [ ] Set up `public/index.php` and `src/Config/Database.php`.
- [ ] Build Models (`Recipe`, `Category`, `User`, `Schedule`, `Favourite`, `UserSettings`, `AuditLog`).
- [ ] Build Controllers, including API logic and admin portal logic.
- [ ] Build Middleware (`CorsMiddleware`, `AuthMiddleware`, `AdminAuthMiddleware` with Role checks).
- [ ] Create ImageCompressor Helper to manage uploads.
- [ ] Write DB Migrations (`001_create_categories.sql` through `007_create_audit_logs.sql`).
- [ ] Create Admin Portal Views (`admin_templates/`).

---

## Verification Plan

### Automated Tests
1. **Database**: Verify PHP / Composer are present. Run migrations, verify all tables created correctly.
2. **API endpoints**: Test each endpoint using `curl` commands:
   - `GET /api/categories` — returns seeded categories
   - `GET /api/recipes/trending` — returns random 5
   - `POST /api/users/register` — device registration
   - Full CRUD cycle for schedules and favourites
3. **Admin portal**: Navigate to `/admin/`, login as Super Admin and normal Admin, verify role permissions.

### Manual Verification
1. Start PHP dev server (`php -S localhost:8000 -t public/`)
2. Open admin portal in browser at `localhost:8000/admin/`
3. Upload a recipe with an image, verify image is compressed and stored as a link.
4. Verify audit logs record payload, response, and status for admin actions.

---

## Implementation Order

| Phase | Components | Priority |
|-------|-----------|----------|
| **1** | Verify PHP/Composer, project scaffold, database setup, migrations | 🔴 Critical |
| **2** | Create `README.md` documentation | 🔴 Critical |
| **3** | Recipe & Category models + controllers + Image Upload/Compression | 🔴 Critical |
| **4** | Search with FULLTEXT + filters + pagination | 🔴 Critical |
| **5** | User registration, settings model + controller (Device UUID focus) | 🟡 High |
| **6** | Schedule + Favourites CRUD (with meal_type) | 🟡 High |
| **7** | Dietary filtering + trending with Unit Conversion helper | 🟡 High |
| **8** | Admin portal — layout, auth (Roles), recipe management | 🟢 Medium |
| **9** | Admin portal — users, audit logs (payload/response), dashboard stats | 🟢 Medium |
