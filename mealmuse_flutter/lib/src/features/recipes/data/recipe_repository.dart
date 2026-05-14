import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:meal_muse/src/core/constants/constants.dart';
import 'package:meal_muse/src/features/recipes/domain/recipe_model.dart';

final dio = Dio();
final logger = Logger();

class RecipeRepository {
  Future<RecipesDetails> getRecipesDetails(int id) async {
    try {
      final response = await dio.get("$apiBaseUrl/recipes/$id");

      if (response.statusCode == 200) {
        // Log the count so you know the call succeeded without printing the massive JSON
        logger.i("Recipe Details: ${response.data}");

        // 2. Parse the single Map directly!
        return RecipesDetails.fromJson(response.data);
      } else {
        logger.e(
          "Failed to fetchrecipes details. Status code ${response.statusCode}",
        );
        throw Exception("Failed to fetc hrecipe details");
      }
    } catch (e, stackTrace) {
      // Catch Dio errors or parsing errors and log the stack trace
      logger.e("Error in getTrendingRecipes", error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}

final recipeDetailsProvider = FutureProvider.family<RecipesDetails, int>((ref, id) async {
  return RecipeRepository().getRecipesDetails(id);
});
