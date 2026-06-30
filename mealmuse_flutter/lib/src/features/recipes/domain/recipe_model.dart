// To parse this JSON data, do
//
//     final recipesDetails = recipesDetailsFromJson(jsonString);

import 'dart:convert';

RecipesDetails recipesDetailsFromJson(String str) => RecipesDetails.fromJson(json.decode(str));

String recipesDetailsToJson(RecipesDetails data) => json.encode(data.toJson());

class RecipesDetails {
    int id;
    String name;
    String slug;
    List<String> images;
    dynamic description;
    int totalTime;
    String servings;
    dynamic ratingValue;
    dynamic ratingCount;
    List<String> ingredients;
    List<String> instructions;
    dynamic author;
    List<dynamic> dietaryTags;
    dynamic nutritionInfo;
    DateTime dateAdded;
    List<Category> categories;
    List<ScheduledInstance> scheduledInstances;
    bool isScheduled;

    RecipesDetails({
        required this.id,
        required this.name,
        required this.slug,
        required this.images,
        required this.description,
        required this.totalTime,
        required this.servings,
        required this.ratingValue,
        required this.ratingCount,
        required this.ingredients,
        required this.instructions,
        required this.author,
        required this.dietaryTags,
        required this.nutritionInfo,
        required this.dateAdded,
        required this.categories,
        required this.scheduledInstances,
        required this.isScheduled,
    });

    factory RecipesDetails.fromJson(Map<String, dynamic> json) => RecipesDetails(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        images: List<String>.from(json["images"].map((x) => x)),
        description: json["description"],
        totalTime: json["total_time"],
        servings: json["servings"],
        ratingValue: json["rating_value"],
        ratingCount: json["rating_count"],
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        instructions: List<String>.from(json["instructions"].map((x) => x)),
        author: json["author"],
        dietaryTags: List<dynamic>.from(json["dietary_tags"].map((x) => x)),
        nutritionInfo: json["nutrition_info"],
        dateAdded: DateTime.parse(json["date_added"]),
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        scheduledInstances: List<ScheduledInstance>.from(json["scheduled_instances"].map((x) => ScheduledInstance.fromJson(x))),
        isScheduled: json["is_scheduled"],
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
        "rating_count": ratingCount,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
        "instructions": List<dynamic>.from(instructions.map((x) => x)),
        "author": author,
        "dietary_tags": List<dynamic>.from(dietaryTags.map((x) => x)),
        "nutrition_info": nutritionInfo,
        "date_added": dateAdded.toIso8601String(),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "scheduled_instances": List<dynamic>.from(scheduledInstances.map((x) => x.toJson())),
        "is_scheduled": isScheduled,
    };
}

class Category {
    int id;
    String name;
    String mealType;
    DateTime createdAt;

    Category({
        required this.id,
        required this.name,
        required this.mealType,
        required this.createdAt,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        mealType: json["meal_type"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "meal_type": mealType,
        "created_at": createdAt.toIso8601String(),
    };
}

class ScheduledInstance {
    int scheduleId;
    String dayOfWeek;
    String mealType;

    ScheduledInstance({
        required this.scheduleId,
        required this.dayOfWeek,
        required this.mealType,
    });

    factory ScheduledInstance.fromJson(Map<String, dynamic> json) => ScheduledInstance(
        scheduleId: json["schedule_id"],
        dayOfWeek: json["day_of_week"],
        mealType: json["meal_type"],
    );

    Map<String, dynamic> toJson() => {
        "schedule_id": scheduleId,
        "day_of_week": dayOfWeek,
        "meal_type": mealType,
    };
}
