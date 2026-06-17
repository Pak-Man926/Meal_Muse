import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:meal_muse/src/core/constants/constants.dart';
import 'package:meal_muse/src/features/auth/application/auth_service.dart';
import 'package:meal_muse/src/features/auth/domain/register_user_model.dart';

final dio = Dio();
final logger = Logger();

class RegisterUserRepository {
  final AuthService _authService;

  RegisterUserRepository({AuthService? authService})
    : _authService = authService ?? AuthService();

  Future<RegisterUser> registerUser() async {
    try {
      final response = await dio.post(
        "$apiBaseUrl/users/register",
        data: {"device_uuid": await _authService.getDeviceUuid()},
      );

      if (response.statusCode == 200) {
        final registeredUser = RegisterUser.fromJson(response.data);
        logger.i(
          "${registeredUser.message ?? 'User Registered Successfully.'} \n ${response.data}",
        );
        return registeredUser;
      } else {
        logger.e(
          "Failed to register user. Status code: ${response.statusCode}",
        );
        throw Exception("Failed to register user");
      }
    } catch (e, stackTrace) {
      logger.e(
        "Error occurred while registering user. Error:$e  StackTrace: $stackTrace",
      );
      throw Exception("Error occurred while registering user");
    }
  }
}
