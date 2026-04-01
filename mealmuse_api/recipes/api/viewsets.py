"""
ViewSets for the Meal Muse API.

RecipeViewSet provides all standard CRUD endpoints plus:
  GET /api/recipe/trending/           → top-rated recipes (home screen carousel)
  GET /api/recipe/random/             → a random selection (inspire me)
  GET /api/recipe/?categories=<id>    → filter by category id(s)
  GET /api/recipe/?search=<term>      → full-text search (PostgreSQL ranked)
  GET /api/recipe/<id>/               → full recipe detail (with ingredients + steps)

CategoryViewSet provides:
  GET /api/category/                  → all categories with recipe_count
  GET /api/category/?type=meal_types  → filter by category type
"""

import random as py_random

from django.db.models import Count
from django.utils.decorators import method_decorator
from django.views.decorators.cache import cache_page
from django.views.decorators.gzip import gzip_page
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.filters import OrderingFilter
from rest_framework.permissions import AllowAny
from rest_framework.response import Response

from recipes.api.filters import SearchVectorFilter, RecipeFilter
from recipes.api.pagination import FlexiblePageNumberPagination
from recipes.api.serializers import (
    CategorySerializer,
    RecipeListSerializer,
    RecipeDetailSerializer,
)
from recipes.models import Category, Recipe

CACHE_MINUTE = 60
CACHE_HOUR = CACHE_MINUTE * 60
CACHE_DAY = CACHE_HOUR * 24

# Number of recipes returned by /api/recipe/trending/
TRENDING_COUNT = 20


# ──────────────────────────────────────────────────────────────────
# Category
# ──────────────────────────────────────────────────────────────────


@method_decorator(gzip_page, name="dispatch")
@method_decorator(cache_page(timeout=CACHE_DAY), name="dispatch")
class CategoryViewSet(viewsets.ReadOnlyModelViewSet):
    """
    Read-only endpoint for recipe categories.

    Query params:
        ?type=meal_types        filter by category type
        ?type=dish_types
        ?type=cuisines
        ?type=special_diets
        ?search=kenya           search by name

    Response includes `recipe_count` for each category so the Flutter
    app can hide empty categories.
    """

    queryset = Category.objects.annotate(
        recipe_count=Count("recipe", distinct=True)
    ).order_by("type", "name")
    serializer_class = CategorySerializer
    permission_classes = [AllowAny]
    pagination_class = None  # return all categories in a single list
    filterset_fields = ["name", "type"]
    search_fields = ["name"]


# ──────────────────────────────────────────────────────────────────
# Recipe
# ──────────────────────────────────────────────────────────────────


@method_decorator(gzip_page, name="dispatch")
class RecipeViewSet(viewsets.ReadOnlyModelViewSet):
    """
    Read-only endpoint for recipes.

    ## List / Search
        GET /api/recipe/
        GET /api/recipe/?search=ugali
        GET /api/recipe/?search=pilau&page_size=10
        GET /api/recipe/?categories=3&categories=7   (must match ALL listed categories)
        GET /api/recipe/?ordering=-rating_value       (sort by rating, newest, etc.)

    ## Detail
        GET /api/recipe/<id>/                         (full recipe with ingredients + steps)

    ## Special actions
        GET /api/recipe/trending/                     (top-rated, for home screen)
        GET /api/recipe/trending/?count=10            (control how many)
        GET /api/recipe/random/                       (random picks, for discovery)
        GET /api/recipe/random/?count=5
    """

    queryset = Recipe.objects.prefetch_related("categories")
    filterset_class = RecipeFilter
    filter_backends = (SearchVectorFilter, DjangoFilterBackend, OrderingFilter)
    search_fields = ["search_vector"]
    ordering_fields = ["rating_value", "rating_count", "date_added"]
    ordering = ["-date_added"]
    permission_classes = [AllowAny]
    pagination_class = FlexiblePageNumberPagination

    def get_serializer_class(self):
        """
        Use the lightweight list serializer for collections,
        and the full detail serializer for individual recipe lookups.
        """
        if self.action == "retrieve":
            return RecipeDetailSerializer
        return RecipeListSerializer

    @method_decorator(cache_page(timeout=CACHE_HOUR))
    def list(self, request, *args, **kwargs):
        return super().list(request, *args, **kwargs)

    @method_decorator(cache_page(timeout=CACHE_HOUR))
    def retrieve(self, request, *args, **kwargs):
        return super().retrieve(request, *args, **kwargs)

    # ── GET /api/recipe/trending/ ──────────────────────────────────
    @action(
        detail=False,
        methods=["get"],
        url_path="trending",
        permission_classes=[AllowAny],
    )
    @method_decorator(cache_page(timeout=CACHE_HOUR))
    def trending(self, request):
        """
        Returns the highest-rated recipes.
        The Flutter home screen uses this for the Trending Recipes carousel.

        Query params:
            ?count=N    number of recipes to return (default 20, max 100)
        """
        count = min(int(request.query_params.get("count", TRENDING_COUNT)), 100)
        qs = (
            Recipe.objects.prefetch_related("categories")
            .filter(rating_value__isnull=False)
            .order_by("-rating_value", "-rating_count")[:count]
        )
        serializer = RecipeListSerializer(qs, many=True, context={"request": request})
        return Response(
            {
                "count": len(serializer.data),
                "results": serializer.data,
            }
        )

    # ── GET /api/recipe/random/ ────────────────────────────────────
    @action(
        detail=False, methods=["get"], url_path="random", permission_classes=[AllowAny]
    )
    def random(self, request):
        """
        Returns a random selection of recipes.
        Useful for an "Inspire Me" / "What should I cook today?" feature.

        Query params:
            ?count=N    number of recipes to return (default 5, max 20)
        """
        count = min(int(request.query_params.get("count", 5)), 20)
        # Use database-level random ordering (efficient for Postgres)
        qs = Recipe.objects.prefetch_related("categories").order_by("?")[:count]
        serializer = RecipeListSerializer(qs, many=True, context={"request": request})
        return Response(
            {
                "count": len(serializer.data),
                "results": serializer.data,
            }
        )
