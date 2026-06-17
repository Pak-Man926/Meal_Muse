import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class AuthService {
  final logger = Logger();
  final box = GetStorage();

  Future<String?> getDeviceUuid() async {
    String? storedUuid = box.read("device_uuid");
    if (storedUuid != null) {
      return storedUuid;
    }

    var deviceInfo = DeviceInfoPlugin();
    String? newUuid;

    if (kIsWeb) {
      var webInfo = await deviceInfo.webBrowserInfo;
      newUuid =
          "web_${DateTime.now().millisecondsSinceEpoch}_${webInfo.browserName.name}";
    } else if (Platform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      newUuid = androidInfo.id;
    } else if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      newUuid = iosInfo.identifierForVendor;
    } else if (Platform.isLinux) {
      var linuxInfo = await deviceInfo.linuxInfo;
      newUuid = linuxInfo.machineId;
    } else if (Platform.isWindows) {
      var windowsInfo = await deviceInfo.windowsInfo;
      newUuid = windowsInfo.deviceId;
    } else if (Platform.isMacOS) {
      var macInfo = await deviceInfo.macOsInfo;
      newUuid = macInfo.systemGUID;
    } else {
      newUuid = "unknown_${DateTime.now().millisecondsSinceEpoch}";
    }

    if (newUuid != null) {
      box.write("device_uuid", newUuid);
    }

    return newUuid;
  }
}
