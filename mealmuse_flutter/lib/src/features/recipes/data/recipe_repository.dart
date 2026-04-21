import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_muse/src/features/recipes/domain/recipe.dart';

/// The Data Layer (Repository) handles data retrieval and submission.
/// It interacts with the outside world (APIs, Databases, etc.) to fetch raw data
/// and returns clean Domain models (like Recipe) back to the UI/Providers.
class RecipeRepository {
  // In a real application, you'd inject Dio, http.Client, or a local DB here
  // final HttpClient apiClient;
  // RecipeRepository({required this.apiClient});

  Future<List<Recipe>> fetchRecipes() async {
    // 1. Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // 2. Mocking an API response mapping
    // final response = await apiClient.get('/api/recipes');
    // return (response.data as List).map((json) => Recipe.fromJson(json)).toList();

    return [
      Recipe(
        imageUrl:
            "https://www.themealdb.com/images/media/meals/58oia61564916529.jpg",
        name: "Sample Repo Recipe",
        description:
            "This data came from the newly created Repository pattern in the data/ folder.",
        ingredients: ["Ingredient A", "Ingredient B"],
        procedure: ["Step 1", "Step 2"],
      ),
    ];
  }
}

/// Creates a singleton-like instance of your repository that can be accessed globally
final recipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  return RecipeRepository();
});

/// A FutureProvider that handles calling the API and giving the results to the UI.
/// UI widgets can do: `ref.watch(recipesProvider).when(data: ..., loading: ..., error: ...)`
final recipesFutureProvider = FutureProvider<List<Recipe>>((ref) async {
  final repository = ref.watch(recipeRepositoryProvider);
  return repository.fetchRecipes();
});
