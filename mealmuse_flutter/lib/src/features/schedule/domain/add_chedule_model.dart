// To parse this JSON data, do
//
//     final addSchedule = addScheduleFromJson(jsonString);

import 'dart:convert';

AddSchedule addScheduleFromJson(String str) => AddSchedule.fromJson(json.decode(str));

String addScheduleToJson(AddSchedule data) => json.encode(data.toJson());

class AddSchedule {
    int recipeId;
    String dayOfWeek;
    String mealType;

    AddSchedule({
        required this.recipeId,
        required this.dayOfWeek,
        required this.mealType,
    });

    factory AddSchedule.fromJson(Map<String, dynamic> json) => AddSchedule(
        recipeId: json["recipe_id"],
        dayOfWeek: json["day_of_week"],
        mealType: json["meal_type"],
    );

    Map<String, dynamic> toJson() => {
        "recipe_id": recipeId,
        "day_of_week": dayOfWeek,
        "meal_type": mealType,
    };
}
