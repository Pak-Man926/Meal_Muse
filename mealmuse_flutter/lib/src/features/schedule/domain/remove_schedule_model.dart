// To parse this JSON data, do
//
//     final removeSchedule = removeScheduleFromJson(jsonString);

import 'dart:convert';

RemoveSchedule removeScheduleFromJson(String str) =>
    RemoveSchedule.fromJson(json.decode(str));

String removeScheduleToJson(RemoveSchedule data) => json.encode(data.toJson());

class RemoveSchedule {
  String message;

  RemoveSchedule({required this.message});

  factory RemoveSchedule.fromJson(Map<String, dynamic> json) =>
      RemoveSchedule(message: json["message"]);

  Map<String, dynamic> toJson() => {"message": message};
}
