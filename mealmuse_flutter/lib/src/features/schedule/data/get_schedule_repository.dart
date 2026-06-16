import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:meal_muse/src/core/constants/constants.dart';
import 'package:meal_muse/src/features/schedule/domain/get_schedule_model.dart';

final dio = Dio();
final logger = Logger();
final box = GetStorage();

class GetScheduleRepository {
  Future<List<GetSchedule>> getSchedule(String day) async {
    try {
      var userId = box.read("user_id");
      var deviceUuid = box.read("device_uuid");
      if (userId == null || deviceUuid == null) {
        logger.e("User ID or Device UUID not found in storage.");
        throw Exception("User ID or Device UUID not found in storage.");
      }
      var response = await dio.get(
        "$apiBaseUrl/users/$userId/schedule",
        options: Options(headers: {"X-Device-ID": deviceUuid}),
        queryParameters: {"day": day},
      );

      if (response.statusCode == 200) {
        logger.i(
          "Schedule fetched successfully for User ID: $userId with the data: ${response.data}",
        );

        return (response.data as List).map((x) => GetSchedule.fromJson(x)).toList();
      } else {
        logger.e(
          "Failed to fetch schedule. Status code: ${response.statusCode}",
        );
        throw Exception(
          "Failed to fetch schedule. Status code: ${response.statusCode}",
        );
      }
    } catch (e, stackTrace) {
      logger.e(
        "Error fetching schedule for User ID: ${box.read("user_id")}",
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

final getScheduleProvider = FutureProvider.family<List<GetSchedule>, String>((ref, day) async {
  return GetScheduleRepository().getSchedule(day);
});