import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:get_storage/get_storage.dart";
import "package:logger/logger.dart";
import "package:meal_muse/src/app.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import "package:meal_muse/src/features/auth/data/register_user_repository.dart";

final logger = Logger();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  packageInfo = await PackageInfo.fromPlatform();
  await GetStorage.init();
  await dotenv.load();

  // Soft Auth: Register device UUID in the background silently
  try {
    RegisterUserRepository()
        .registerUser()
        .then((registerUser) {
          logger.i(
            "Soft Auth: User registered with ID: ${registerUser.userId}",
          );
        })
        .catchError((error) {
          logger.e("Soft Auth: Failed to register user. Error: $error");
        });
  } catch (e, stackTrace) {
    logger.e(
      "Soft Auth: Exception occurred during user registration. Error: $e StackTrace: $stackTrace",
    );
  }

  runApp(ProviderScope(child: const MyApp()));
}
