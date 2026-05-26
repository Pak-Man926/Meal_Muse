// To parse this JSON data, do
//
//     final recipeCategories = recipeCategoriesFromJson(jsonString);

import 'dart:convert';

List<RecipeCategories> recipeCategoriesFromJson(String str) => List<RecipeCategories>.from(json.decode(str).map((x) => RecipeCategories.fromJson(x)));

String recipeCategoriesToJson(List<RecipeCategories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecipeCategories {
    int id;
    String name;
    String mealType;
    DateTime createdAt;
    int recipeCount;

    RecipeCategories({
        required this.id,
        required this.name,
        required this.mealType,
        required this.createdAt,
        required this.recipeCount,
    });

    factory RecipeCategories.fromJson(Map<String, dynamic> json) => RecipeCategories(
        id: json["id"],
        name: json["name"],
        mealType: json["meal_type"],
        createdAt: DateTime.parse(json["created_at"]),
        recipeCount: json["recipe_count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "meal_type": mealType,
        "created_at": createdAt.toIso8601String(),
        "recipe_count": recipeCount,
    };
}
