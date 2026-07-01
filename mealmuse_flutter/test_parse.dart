import 'dart:convert';
import 'lib/src/features/recipes/domain/recipe_model.dart';

void main() {
  String jsonString = '''
  {
      "id": 19,
      "name": "Ugali, Tomato Scrambled Eggs, Sukuma Wiki, and Avocado",
      "slug": "ugali-tomato-scrambled-eggs-sukuma-wiki-and-avocado",
      "images": [
          "/uploads/recipe_69f87f2a40188_1777893162.jpg"
      ],
      "description": null,
      "total_time": 40,
      "servings": "3",
      "rating_value": null,
      "rating_count": null,
      "ingredients": [
          "2 cups maize flour (unga)"
      ],
      "instructions": [
          "Bring 4 cups of water to a rolling boil"
      ],
      "author": null,
      "dietary_tags": [],
      "nutrition_info": null,
      "date_added": "2026-05-04 11:12:42",
      "categories": [
          {
              "id": 3,
              "name": "Dinner",
              "meal_type": "dinner",
              "created_at": "2026-04-28 14:56:53"
          }
      ],
      "is_scheduled": true,
      "scheduled_instances": [
          {
              "schedule_id": 25,
              "day_of_week": "thursday",
              "meal_type": "dinner"
          }
      ]
  }
  ''';

  var parsed = json.decode(jsonString);
  try {
    var details = RecipesDetails.fromJson(parsed);
    print(
      "Parsed successfully. isScheduled: " + details.isScheduled.toString(),
    );
  } catch (e) {
    print("Error parsing: " + e.toString());
  }
}
