"""recipe_api URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include, re_path
from recipes import views
import recipes.api.urls
from drf_spectacular.views import SpectacularAPIView, SpectacularRedocView, SpectacularSwaggerView

urlpatterns = [
    # admin
    path('admin/', admin.site.urls),
    # api auth
    path('api-auth/', include('rest_framework.urls')),
    # api documentation
    path('api/schema/', SpectacularAPIView.as_view(), name='schema'),
    path('api/docs/', SpectacularSwaggerView.as_view(url_name='schema'), name='swagger-ui'),
    path('api/redoc/', SpectacularRedocView.as_view(url_name='schema'), name='redoc'),
    # api
    path('api/', include(recipes.api.urls)),
]

from django.conf import settings
from django.conf.urls.static import static
if settings.DEBUG:
    # Serve the files from the place collectstatic gathers from (where scrape_cookpad writes)
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATICFILES_DIRS[0])

urlpatterns += [
    # just the recipe - redirect
    re_path('^http.*', views.just_the_recipe),
    # main
    path('', views.main, name='main')
]
