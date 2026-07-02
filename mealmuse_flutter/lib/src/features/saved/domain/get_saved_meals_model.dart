// To parse this JSON data, do
//
//     final getFavourite = getFavouriteFromJson(jsonString);

import 'dart:convert';

GetFavourite getFavouriteFromJson(String str) =>
    GetFavourite.fromJson(json.decode(str));

String getFavouriteToJson(GetFavourite data) => json.encode(data.toJson());

class GetFavourite {
  int count;
  List<Result> results;

  GetFavourite({required this.count, required this.results});

  factory GetFavourite.fromJson(Map<String, dynamic> json) => GetFavourite(
    count: json["count"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  int favouriteId;
  DateTime createdAt;
  dynamic mealType;
  Recipe recipe;

  Result({
    required this.favouriteId,
    required this.createdAt,
    required this.mealType,
    required this.recipe,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    favouriteId: json["favourite_id"],
    createdAt: DateTime.parse(json["created_at"]),
    mealType: json["meal_type"],
    recipe: Recipe.fromJson(json["recipe"]),
  );

  Map<String, dynamic> toJson() => {
    "favourite_id": favouriteId,
    "created_at": createdAt.toIso8601String(),
    "meal_type": mealType,
    "recipe": recipe.toJson(),
  };
}

class Recipe {
  int id;
  String name;
  String slug;
  List<String> images;
  int totalTime;
  dynamic ratingValue;

  Recipe({
    required this.id,
    required this.name,
    required this.slug,
    required this.images,
    required this.totalTime,
    required this.ratingValue,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    images: List<String>.from(json["images"].map((x) => x)),
    totalTime: json["total_time"],
    ratingValue: json["rating_value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "images": List<dynamic>.from(images.map((x) => x)),
    "total_time": totalTime,
    "rating_value": ratingValue,
  };
}
