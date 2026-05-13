import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_riverpod/legacy.dart";

// A Notifier that manages a list of selected dietary restrictions
class DietaryRestrictionsNotifier extends StateNotifier<List<String>> {
  DietaryRestrictionsNotifier() : super([]);

  void toggleRestriction(String restriction) {
    if (state.contains(restriction)) {
      // Remove if already present
      state = state.where((item) => item != restriction).toList();
    } else {
      // Add if not present
      state = [...state, restriction];
    }
  }
}

// The providers
final dietaryProvider =
    StateNotifierProvider<DietaryRestrictionsNotifier, List<String>>((ref) {
      return DietaryRestrictionsNotifier();
    });

final measurementProvider = StateProvider<bool>((ref) {
  return true;
});

final notificationsProvider = StateProvider<bool>((ref) {
  return false;
});

final recipeRecommendationsProvider = StateProvider<bool>((ref) {
  return false;
});
