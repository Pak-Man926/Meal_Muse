import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:meal_muse/src/core/constants/constants.dart';
import 'package:meal_muse/src/features/saved/domain/add_saved_meals_model.dart';

final dio = Dio();
final logger = Logger();
final box = GetStorage();

class AddSavedMealsRepository {
  Future<AddFavouriteResponse> addFavouriteMeal(int recipeId) async {
    final userId = box.read("user_id");
    final deviceUuid = box.read("device_uuid");

    if (userId == null || deviceUuid == null) {
      logger.e("User ID or Device UUID not found in storage.");
      throw Exception("User ID or Device UUID not found in storage.");
    }

    try {
      final response = await dio.post(
        "$apiBaseUrl/users/$userId/favourites",
        data: {"recipe_id": recipeId},
        options: Options(headers: {"X-Device-ID": deviceUuid}),
      );
      if (response.statusCode == 200) {
        logger.i(
          "Meal added to favourites successfully for User ID: $userId with the data: ${response.data}",
        );
        return AddFavouriteResponse.fromJson(response.data);
      } else {
        logger.e(
          "Failed to add meal to favourites. Status code: ${response.statusCode}",
        );
        throw Exception(
          "Failed to add meal to favourites. Status code: ${response.statusCode}",
        );
      }
    } catch (e, stackTrace) {
      logger.e(
        "Error adding meal to favourites for User ID: $userId",
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

final addSavedMealsProvider = FutureProvider.family<AddFavouriteResponse, int>((
  ref,
  recipeId,
) async {
  return AddSavedMealsRepository().addFavouriteMeal(recipeId);
});
