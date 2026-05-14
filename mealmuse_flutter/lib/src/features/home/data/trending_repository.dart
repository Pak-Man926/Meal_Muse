import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:meal_muse/src/core/constants/constants.dart';
import 'package:meal_muse/src/features/home/domain/trending_recipe_model.dart';

final dio = Dio();
final logger = Logger();

class TrendingRecipesRequest {
  // 1. Changed return type to a single TrendingRecipes object
  Future<TrendingRecipes> getTrendingRecipes() async {
    try {
      final response = await dio.get("$apiBaseUrl/recipes/trending");

      if (response.statusCode == 200) {
        // Log the count so you know the call succeeded without printing the massive JSON
        logger.i(
          "Trending Recipes Fetched Successfully. Count: ${response.data['count']}",
        );

        // 2. Parse the single Map directly!
        return TrendingRecipes.fromJson(response.data);
      } else {
        logger.e(
          "Failed to fetch trending recipes. Status code: ${response.statusCode}",
        );
        throw Exception("Failed to fetch trending recipes");
      }
    } catch (e, stackTrace) {
      // Catch Dio errors or parsing errors and log the stack trace
      logger.e("Error in getTrendingRecipes", error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}

// 3. Provider now returns the single wrapper object
final trendingRecipeProvider = FutureProvider<TrendingRecipes>((ref) async {
  return TrendingRecipesRequest().getTrendingRecipes();
});
