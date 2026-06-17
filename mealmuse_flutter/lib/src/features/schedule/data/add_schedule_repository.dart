import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:meal_muse/src/core/constants/constants.dart';
import 'package:meal_muse/src/features/schedule/domain/add_chedule_model.dart';

final dio = Dio();
final logger = Logger();
final box = GetStorage();

class AddScheduleRepository {
  Future<AddSchedule> addSchedule() async {
    var deviceUuid = box.read("device_uuid");
    var userId = box.read("user_id");

    try {
      var response = await dio.post(
        "$apiBaseUrl/users/$userId/schedules",
        options: Options(headers: {"X-Device-ID": deviceUuid}),
        queryParameters: {
          "recipe_id": 1,
          "day_of_week": "Monday",
          "meal_type": "Breakfast",
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
      logger.e(
        "Error adding schedule for User ID: $userId",
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
