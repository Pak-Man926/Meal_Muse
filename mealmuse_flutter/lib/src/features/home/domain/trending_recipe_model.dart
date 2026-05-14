import 'dart:convert';

TrendingRecipes trendingRecipesFromJson(String str) =>
    TrendingRecipes.fromJson(json.decode(str));

String trendingRecipesToJson(TrendingRecipes data) =>
    json.encode(data.toJson());

class TrendingRecipes {
  int count;
  List<Result> results;

  TrendingRecipes({required this.count, required this.results});

  factory TrendingRecipes.fromJson(Map<String, dynamic> json) =>
      TrendingRecipes(
        count: json["count"],
        results: List<Result>.from(
          json["results"].map((x) => Result.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "count": count,
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
  String? servings;
  dynamic ratingValue;

  Result({
    required this.id,
    required this.name,
    required this.slug,
    required this.images,
    this.description,
    required this.totalTime,
    this.servings,
    this.ratingValue,
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
  };
}
