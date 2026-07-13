import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:meal_muse/src/core/constants/constants.dart';
import 'package:meal_muse/src/features/schedule/domain/add_schedule_model.dart';

final dio = Dio();
final logger = Logger();
final box = GetStorage();

class AddScheduleRepository {
  Future<AddSchedule> addSchedule(
    int recipeId,
    String dayOfWeek,
    String mealType,
  ) async {
    var deviceUuid = box.read("device_uuid");
    var userId = box.read("user_id");

    if (userId == null || deviceUuid == null) {
      logger.e("User ID or Device UUID not found in storage.");
      throw Exception("User ID or Device UUID not found in storage.");
    }

    try {
      var response = await dio.post(
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
          "Schedule added successfully for User ID: $userId with the data: ${response.data}",
        );
        return AddSchedule.fromJson(response.data);
      } else {
        logger.e("Failed to add schedule. Status code: ${response.statusCode}");
        throw Exception(
          "Failed to add schedule. Status code: ${response.statusCode}",
        );
      }
    } catch (e, stackTrace) {
      if (e is DioException &&
          e.response?.data != null &&
          e.response?.data['error'] != null) {
        throw Exception(e.response!.data['error']);
      }
      logger.e(
        "Error adding schedule for User ID: $userId",
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

final addScheduleProvider =
    FutureProvider.family<
      AddSchedule,
      ({int recipeId, String dayOfWeek, String mealType})
    >((ref, params) async {
      final repository = AddScheduleRepository();
      return await repository.addSchedule(
        params.recipeId,
        params.dayOfWeek,
        params.mealType,
      );
    });
