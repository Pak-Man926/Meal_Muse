import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:logger/logger.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/features/home/domain/recipe_categories_model.dart";

final dio = Dio();
final logger = Logger();

class RecipeCategoriesRepository {
  Future<List<RecipeCategories>> fetchCategories() async {
    try {
      final response = await dio.get("$apiBaseUrl/categories");

      if (response.statusCode == 200) {
        logger.i("Recipe Categories Fetched Successfully. \n ${response.data}");
        return List<RecipeCategories>.from(
          (response.data as List).map((x) => RecipeCategories.fromJson(x)),
        );
      } else {
        logger.e(
          "Failed to fetch recipe categories. Status code: ${response.statusCode}",
        );
        throw Exception("Failed to fetch recipe categories");
      }
    } catch (e, stackTrace) {
      logger.e(
        "Error occurred while fetching recipe categories. Error:$e  StackTrace: $stackTrace",
      );
      throw Exception("Error occurred while fetching recipe categories");
    }
  }
}

final apiRecipeCategoriesProvider = FutureProvider<List<RecipeCategories>>((
  ref,
) async {
  return RecipeCategoriesRepository().fetchCategories();
});
