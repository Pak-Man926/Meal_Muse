"""
Serializers for the Meal Muse API.

Three recipe serializer tiers:
  - RecipeListSerializer  → lightweight, used for list/search results
  - RecipeDetailSerializer → full data, used for single recipe detail
  - JustTheRecipeSerializer → for the live URL-scraping endpoint
"""

from rest_framework import serializers

from recipes.models import Category, Recipe


# ──────────────────────────────────────────────────────────────────
# Category
# ──────────────────────────────────────────────────────────────────

class CategorySerializer(serializers.ModelSerializer):
    """Full category data including recipe count."""
    recipe_count = serializers.IntegerField(read_only=True, default=0)

    class Meta:
        model = Category
        fields = ['id', 'name', 'type', 'recipe_count']


class CategoryMiniSerializer(serializers.ModelSerializer):
    """Minimal category data embedded inside recipe responses."""
    class Meta:
        model = Category
        fields = ['id', 'name', 'type']


# ──────────────────────────────────────────────────────────────────
# Recipe — list (lightweight)
# ──────────────────────────────────────────────────────────────────

class RecipeListSerializer(serializers.ModelSerializer):
    """
    Lightweight serializer for recipe list / search results.
    Used by the Home screen carousel, Search screen, and category pages.
    Omits the full ingredients/instructions arrays to keep responses fast.
    """
    categories = CategoryMiniSerializer(many=True, read_only=True)
    search_rank = serializers.FloatField(read_only=True, default=0.0)

    class Meta:
        model = Recipe
        fields = [
            'id',
            'name',
            'slug',
            'image_path',       # relative URL — prefix with server base URL in the app
            'description',
            'total_time_string',
            'servings',
            'rating_value',
            'rating_count',
            'categories',
            'author',
            'date_added',
            'search_rank',
        ]


# ──────────────────────────────────────────────────────────────────
# Recipe — detail (full data)
# ──────────────────────────────────────────────────────────────────

class RecipeDetailSerializer(serializers.ModelSerializer):
    """
    Full serializer for a single recipe detail view.
    Includes ingredients and step-by-step instructions.
    """
    categories = CategoryMiniSerializer(many=True, read_only=True)
    search_rank = serializers.FloatField(read_only=True, default=0.0)
    # Convenience: present ingredients as a plain list (already an ArrayField)
    ingredients = serializers.ListField(child=serializers.CharField())
    instructions = serializers.ListField(child=serializers.CharField())

    class Meta:
        model = Recipe
        fields = [
            'id',
            'name',
            'slug',
            'image_path',
            'description',
            'total_time_string',
            'servings',
            'rating_value',
            'rating_count',
            'ingredients',
            'instructions',
            'categories',
            'author',
            'date_added',
            'search_rank',
        ]


# ──────────────────────────────────────────────────────────────────
# Backward-compat alias (used by the existing NYT scrape tests etc.)
# ──────────────────────────────────────────────────────────────────
RecipeSerializer = RecipeDetailSerializer


# ──────────────────────────────────────────────────────────────────
# Just-the-recipe (URL scraper endpoint)
# ──────────────────────────────────────────────────────────────────

class JustTheRecipeSerializer(serializers.Serializer):
    """
    Serializer for the live URL-scraping endpoint (/api/just-the-recipe/).
    All fields are optional since scraping may not find every field.
    """
    name = serializers.CharField(source='title', required=False, default='')
    image_path = serializers.CharField(source='image', required=False, default='')
    description = serializers.CharField(required=False, default='')
    total_time_string = serializers.CharField(source='total_time', required=False, default='')
    rating_value = serializers.IntegerField(source='ratings', required=False, default=None, allow_null=True)
    rating_count = serializers.IntegerField(source='ratings_count', required=False, default=None, allow_null=True)
    ingredients = serializers.ListField(required=False, default=list)
    instructions = serializers.ListField(source='instructions_list', required=False, default=list)
    servings = serializers.CharField(source='yields', required=False, default='')
