import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meal_muse/src/features/search/data/recipe_search_respository.dart';
import 'package:meal_muse/src/features/search/domain/recipe_search_model.dart';
// import your repository here...

// 1. Provide the repository
final recipeSearchRepositoryProvider = Provider<RecipeSearchRepository>((ref) {
  return RecipeSearchRepository();
});

// 2. StateProvider to hold the current typed query
final searchQueryProvider = StateProvider<String>((ref) => "");

// 3. FutureProvider that automatically runs when the query changes
final recipeSearchResultsProvider = FutureProvider<RecipeSearch?>((ref) async {
  final query = ref.watch(searchQueryProvider);

  // If the search bar is empty, return null immediately without calling the API
  if (query.trim().isEmpty) {
    return null;
  }

  // --- DEBOUNCING LOGIC ---
  // Wait 500 milliseconds before firing the API call.
  // If the user types another letter before 500ms is up, the previous 
  // FutureProvider is disposed and a new one starts.
  var isDisposed = false;
  ref.onDispose(() => isDisposed = true);
  
  await Future.delayed(const Duration(milliseconds: 500));
  
  if (isDisposed) {
    // This request was cancelled by the user typing another letter
    throw Exception("Cancelled for new keystroke");
  }
  // -------------------------

  // Call the API
  final repository = ref.read(recipeSearchRepositoryProvider);
  return repository.searchRecipes(query);
});