// To parse this JSON data, do
//
//     final registerUser = registerUserFromJson(jsonString);

import 'dart:convert';

RegisterUser registerUserFromJson(String str) =>
    RegisterUser.fromJson(json.decode(str));

String registerUserToJson(RegisterUser data) => json.encode(data.toJson());

class RegisterUser {
  int userId;
  String deviceUuid;
  String? message;

  RegisterUser({required this.userId, required this.deviceUuid, this.message});

  factory RegisterUser.fromJson(Map<String, dynamic> json) =>
      RegisterUser(
        userId: json["user_id"], 
        deviceUuid: json["device_uuid"],
        message: json["message"]
      );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "device_uuid": deviceUuid,
    "message": message,
  };
}
