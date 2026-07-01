import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:meal_muse/src/core/constants/constants.dart';
import 'package:meal_muse/src/features/schedule/domain/remove_schedule_model.dart';

final dio = Dio();
final logger = Logger();
final box = GetStorage();

class RemoveScheduleRepository {
  Future<RemoveSchedule> removeSchedule(
    int recipeId,
    String dayOfWeek,
    String mealType,
  ) async {
    final deviceUuid = box.read("device_uuid");
    final userId = box.read("user_id");

    if (userId == null || deviceUuid == null) {
      logger.e("User ID or Device UUID not found in storage.");
      throw Exception("User ID or Device UUID not found in storage.");
    }

    try {
      final response = await dio.delete(
        "$apiBaseUrl/users/$userId/schedule",
        options: Options(headers: {"X-Device-ID": deviceUuid}),
        data: {
          "recipe_id": recipeId,
          "day_of_week": dayOfWeek,
          "meal_type": mealType,
        },
      );

      if (response.statusCode == 200) {
        logger.i(
          "Schedule removed successfully for User ID: $userId with the data: ${response.data}",
        );
        return RemoveSchedule.fromJson(response.data);
      } else {
        logger.e(
          "Failed to remove schedule. Status code: ${response.statusCode}",
        );
        throw Exception(
          "Failed to remove schedule. Status code: ${response.statusCode}",
        );
      }
    } catch (e, stackTrace) {
      logger.e(
        "Error removing schedule for User ID: $userId",
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

final removeScheduleProvider =
    FutureProvider.family<
      RemoveSchedule,
      ({int recipeId, String dayOfWeek, String mealType})
    >((ref, params) async {
      final repository = RemoveScheduleRepository();
      return await repository.removeSchedule(
        params.recipeId,
        params.dayOfWeek,
        params.mealType,
      );
    });
