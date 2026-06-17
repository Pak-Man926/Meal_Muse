// To parse this JSON data, do
//
//     final getSchedule = getScheduleFromJson(jsonString);

import 'dart:convert';

List<GetSchedule> getScheduleFromJson(String str) => List<GetSchedule>.from(
  json.decode(str).map((x) => GetSchedule.fromJson(x)),
);

String getScheduleToJson(List<GetSchedule> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSchedule {
  int id;
  int recipeId;
  String mealType;
  Recipe recipe;

  GetSchedule({
    required this.id,
    required this.recipeId,
    required this.mealType,
    required this.recipe,
  });

  factory GetSchedule.fromJson(Map<String, dynamic> json) => GetSchedule(
    id: json["id"],
    recipeId: json["recipe_id"],
    mealType: json["meal_type"],
    recipe: Recipe.fromJson(json["recipe"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "recipe_id": recipeId,
    "meal_type": mealType,
    "recipe": recipe.toJson(),
  };
}

class Recipe {
  String name;
  String slug;
  List<String> images;
  int totalTime;

  Recipe({
    required this.name,
    required this.slug,
    required this.images,
    required this.totalTime,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    name: json["name"],
    slug: json["slug"],
    images: List<String>.from(json["images"].map((x) => x)),
    totalTime: json["total_time"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "images": List<dynamic>.from(images.map((x) => x)),
    "total_time": totalTime,
  };
}
