import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:meal_muse/src/core/constants/constants.dart";
import 'package:meal_muse/src/core/presentation/widgets/container_widget.dart';
import "package:meal_muse/src/features/recipes/presentation/widgets/recipe_card_widget.dart";
import "package:meal_muse/src/features/search/data/recipe_search_provider.dart";

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResultsAsync = ref.watch(recipeSearchResultsProvider);

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Search Recipes", style: theme.textTheme.titleLarge),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    //controller: TextEditingController(),
                    decoration: InputDecoration(
                      hintText: "Search for recipes",
                      focusColor: theme.colorScheme.primary.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      ref.read(searchQueryProvider.notifier).state = value;
                    },
                  ),
                ),
              ],
            ),
            mediumSpaceSize,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ContainerWidget.extended(
                  label: "Quick Recipes",
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                ),
                ContainerWidget.extended(
                  label: "Healthy",
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                ),
                ContainerWidget.extended(
                  label: "Vegan",
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                ),
                ContainerWidget.extended(
                  label: "Gluten-free",
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                ),
                ContainerWidget.extended(
                  label: "Italian",
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                ),
                ContainerWidget.extended(
                  label: "Under 30 minutes",
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                ),
                ContainerWidget.extended(
                  label: "Breakfast",
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                ),
              ],
            ),
            mediumSpaceSize,
            Text(
              "Results",
              style: theme.textTheme.headlineMedium!.copyWith(fontSize: 22),
            ),
            mediumSpaceSize,
            Expanded(
              child: searchResultsAsync.when(
                // 1. Loading State
                loading: () => const Center(child: CircularProgressIndicator()),

                // 2. Error State (Ignore the "Cancelled" errors from debouncing)
                error: (error, stack) {
                  if (error.toString().contains("Cancelled")) {
                    return const SizedBox.shrink();
                  }
                  return Center(child: Text("Error: $error"));
                },

                // 3. Data State
                data: (data) {
                  // If the search bar is empty
                  if (data == null) {
                    return const Center(
                      child: Text("Start typing to search..."),
                    );
                  }

                  // If the API returned 0 results
                  if (data.results.isEmpty) {
                    return const Center(child: Text("No recipes found."));
                  }

                  // Render the actual data
                  return ListView.builder(
                    itemCount: data.results.length,
                    itemBuilder: (context, index) {
                      final recipe = data.results[index];

                      // Handle potential missing images
                      final imagePath = recipe.images.isNotEmpty
                          ? "$imageBaseUrl${recipe.images.first}"
                          : "https://via.placeholder.com/400";

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: RecipeCardWidget(
                          onTap: () {
                            context.push("/recipes/${recipe.id}");
                          },
                          // Use NetworkImage for remote images instead of Image.asset
                          image: Image.network(imagePath, fit: BoxFit.cover),
                          heading: recipe.name,
                          // Combine duration and servings for the subHeading
                          subHeading:
                              "${recipe.totalTime} mins | ${recipe.servings} servings",
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
