#!/bin/bash
set -e

echo "=== Meal Muse API: Clean Setup & Data Wipe ==="

echo "1. Tearing down existing containers and wiping database volumes..."
docker compose down -v

echo "2. Clearing cached local images and SQLite fallback DB..."
rm -rf static/recipes/*
rm -rf staticfiles/recipes/*
rm -rf /tmp/recipes
rm -f db.sqlite3

echo "3. Starting PostgreSQL..."
docker compose up -d postgres

echo "Waiting for PostgreSQL to initialize (5s)..."
sleep 5

echo "4. Activating virtual environment and ensuring dependencies..."
if [ -f "venv/bin/activate" ]; then
    source venv/bin/activate
    pip install -r requirements.txt
else
    echo "Warning: 'venv/bin/activate' not found. You may need to create a virtual environment first."
fi

echo "5. Running fresh Django migrations and creating cache table..."
python manage.py migrate
python manage.py createcachetable

echo "6. Seeding database with a quick sample of recipes (Keyword: 'ugali')..."
python manage.py scrape_cookpad --keyword ugali --max-pages 1

echo "=== Setup complete! ==="
echo "The API has been rebuilt cleanly from scratch."
echo "You can now start the dev server directly:"
echo "  source venv/bin/activate"
echo "  DEBUG=1 python manage.py runserver"
