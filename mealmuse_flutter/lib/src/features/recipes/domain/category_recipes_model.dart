// To parse this JSON data, do
//
//     final categoriesRecipe = categoriesRecipeFromJson(jsonString);

import 'dart:convert';

CategoriesRecipe categoriesRecipeFromJson(String str) =>
    CategoriesRecipe.fromJson(json.decode(str));

String categoriesRecipeToJson(CategoriesRecipe data) =>
    json.encode(data.toJson());

class CategoriesRecipe {
  int count;
  int page;
  int perPage;
  int totalPages;
  int totalItems;
  List<Result> results;

  CategoriesRecipe({
    required this.count,
    required this.page,
    required this.perPage,
    required this.totalPages,
    required this.totalItems,
    required this.results,
  });

  factory CategoriesRecipe.fromJson(Map<String, dynamic> json) =>
      CategoriesRecipe(
        count: json["count"],
        page: json["page"],
        perPage: json["per_page"],
        totalPages: json["total_pages"],
        totalItems: json["total_items"],
        results: List<Result>.from(
          json["results"].map((x) => Result.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "count": count,
    "page": page,
    "per_page": perPage,
    "total_pages": totalPages,
    "total_items": totalItems,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  int id;
  String name;
  String slug;
  List<String> images;
  dynamic description;
  int totalTime;
  String servings;
  dynamic ratingValue;
  DateTime dateAdded;

  Result({
    required this.id,
    required this.name,
    required this.slug,
    required this.images,
    required this.description,
    required this.totalTime,
    required this.servings,
    required this.ratingValue,
    required this.dateAdded,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    images: List<String>.from(json["images"].map((x) => x)),
    description: json["description"],
    totalTime: json["total_time"],
    servings: json["servings"],
    ratingValue: json["rating_value"],
    dateAdded: DateTime.parse(json["date_added"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "images": List<dynamic>.from(images.map((x) => x)),
    "description": description,
    "total_time": totalTime,
    "servings": servings,
    "rating_value": ratingValue,
    "date_added": dateAdded.toIso8601String(),
  };
}
