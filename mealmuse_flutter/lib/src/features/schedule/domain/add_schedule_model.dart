// To parse this JSON data, do
//
//     final addSchedule = addScheduleFromJson(jsonString);

import 'dart:convert';

AddSchedule addScheduleFromJson(String str) =>
    AddSchedule.fromJson(json.decode(str));

String addScheduleToJson(AddSchedule data) => json.encode(data.toJson());

class AddSchedule {
  String message;
  int id;

  AddSchedule({required this.message, required this.id});

  factory AddSchedule.fromJson(Map<String, dynamic> json) => AddSchedule(
    message: json["message"],
    id: json["id"] is int
        ? json["id"]
        : int.tryParse(json["id"].toString()) ?? 0,
  );

  Map<String, dynamic> toJson() => {"message": message, "id": id};
}
