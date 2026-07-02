import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:meal_muse/src/core/constants/constants.dart';
import 'package:meal_muse/src/features/saved/domain/get_saved_meals_model.dart';

final dio = Dio();
final logger = Logger();
final box = GetStorage();

class GetSavedMealsRepository {
  Future<GetFavourite> getSavedMeals() async {
    final userId = box.read("user_id");
    final deviceUuid = box.read("device_uuid");

    if (userId == null || deviceUuid == null) {
      logger.e("User ID or Device UUID not found in storage.");
      throw Exception("User ID or Device UUID not found in storage.");
    }

    try {
      final response = await dio.get(
        "$apiBaseUrl/users/$userId/favourites",
        options: Options(headers: {"X-Device-ID": deviceUuid}),
      );

      if (response.statusCode == 200) {
        logger.i(
          "Saved meals fetched successfully for User ID: $userId with the data: ${response.data}",
        );
        return GetFavourite.fromJson(response.data);
      } else {
        logger.e(
          "Failed to fetch saved meals. Status code: ${response.statusCode}",
        );
        throw Exception(
          "Failed to fetch saved meals. Status code: ${response.statusCode}",
        );
      }
    } catch (e, stackTrace) {
      logger.e(
        "Error fetching saved meals for User ID: $userId",
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

final getSavedMealsProvider = FutureProvider<GetFavourite>((ref) async {
  return GetSavedMealsRepository().getSavedMeals();
});
