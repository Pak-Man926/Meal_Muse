import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:meal_muse/src/core/constants/constants.dart';
import 'package:meal_muse/src/features/recipes/domain/recipe_model.dart';

final dio = Dio();
final logger = Logger();
final box = GetStorage();

class RecipeRepository {
  Future<RecipesDetails> getRecipesDetails(int id) async {
    var deviceUuid = box.read("device_uuid");
    if (deviceUuid == null) {
      logger.e("Device UUID not found in storage.");
      throw Exception("Device UUID not found in storage.");
    }
    try {
      final response = await dio.get(
        "$apiBaseUrl/recipes/$id",
        options: Options(headers: {"X-Device-ID": deviceUuid}),
      );

      if (response.statusCode == 200) {
        // Log the count so you know the call succeeded without printing the massive JSON
        logger.i("Recipe Details: ${response.data}");

        // 2. Parse the single Map directly!
        return RecipesDetails.fromJson(response.data);
      } else {
        logger.e(
          "Failed to fetch recipes details. Status code ${response.statusCode}",
        );
        throw Exception("Failed to fetch recipe details");
      }
    } catch (e, stackTrace) {
      // Catch Dio errors or parsing errors and log the stack trace
      logger.e("Error in get Recipes", error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}

final recipeDetailsProvider = FutureProvider.autoDispose
    .family<RecipesDetails, int>((ref, id) async {
      return RecipeRepository().getRecipesDetails(id);
    });
