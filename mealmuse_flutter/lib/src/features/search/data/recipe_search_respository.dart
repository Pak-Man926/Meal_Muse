import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:meal_muse/src/core/constants/constants.dart';
import 'package:meal_muse/src/features/search/domain/recipe_search_model.dart';

final dio = Dio();
final logger = Logger();

class RecipeSearchRepository {
  Future<RecipeSearch> searchRecipes(String query) async {
    try {
      final response = await dio.get(
        "$apiBaseUrl/recipes?search=$query",
        queryParameters: {"search": query},
      );

      if (response.statusCode == 200) {
        logger.i(
          "Recipe Search Successful for query: $query, with results: ${response.data["results"]}",
        );

        return RecipeSearch.fromJson(response.data);
      } else {
        logger.e(
          "Failed to search recipes for query: $query. Status code: ${response.statusCode}",
        );
        throw Exception("Failed to search recipes");
      }
    } catch (e, stackTrace) {
      logger.e(
        "Error in searchRecipes for query: $query",
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
