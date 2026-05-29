
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:meal_muse/src/core/constants/constants.dart';
import 'package:meal_muse/src/features/recipes/domain/category_recipes_model.dart';

final dio = Dio();
final logger = Logger();

class CategoryRecipeRequests
{
  Future<CategoriesRecipe> getCategoryRecipes(int categoryId) async {
    try{
      final response = await dio.get("$apiBaseUrl/categories/$categoryId/recipes");

      if (response.statusCode == 200)
      {
        logger.i("Category Recipes Fetched Successfully for Category ID: $categoryId. Count: ${response.data['count']}");

        return CategoriesRecipe.fromJson(response.data);
      }
      else
      {
        logger.e("Failed to fetch category recipes for Category ID: $categoryId. Status code: ${response.statusCode}");
        throw Exception("Failed to fetch category recipes");
      }
    }
    catch (e, stackTrace)
    {
      logger.e("Error in getCategoryRecipes for Category ID: $categoryId", error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}

final categoryRecipesProvider = FutureProvider.family<CategoriesRecipe, int>((ref, categoryId) async {
  return CategoryRecipeRequests().getCategoryRecipes(categoryId);
});