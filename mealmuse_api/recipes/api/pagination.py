"""
Custom pagination for the Meal Muse API.

Allows Flutter clients to control page size via ?page_size=N (capped at 100).
Response envelope includes `count`, `next`, `previous`, and `results`.
"""

from rest_framework.pagination import PageNumberPagination


class FlexiblePageNumberPagination(PageNumberPagination):
    """
    Standard page-number pagination with a dynamic page_size query param.

    Flutter usage:
        GET /api/recipe/?page=1&page_size=10      → first 10 recipes
        GET /api/recipe/?page=2&page_size=10      → next 10 recipes
    """
    page_size = 20
    page_size_query_param = 'page_size'
    max_page_size = 100
    page_query_param = 'page'
