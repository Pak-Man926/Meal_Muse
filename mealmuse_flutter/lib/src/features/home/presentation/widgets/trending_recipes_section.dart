import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:meal_muse/src/core/constants/constants.dart';
import 'package:meal_muse/src/features/home/data/trending_recipe_repository.dart';
import 'package:meal_muse/src/features/home/presentation/models/carousel_items.dart';
import 'package:meal_muse/src/features/home/presentation/widgets/carousel_slider_widget.dart';

class TrendingRecipesSection extends ConsumerWidget {
  const TrendingRecipesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendingRecipeState = ref.watch(trendingRecipeProvider);

    return trendingRecipeState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        Logger().e("Widget failed to render recipes", error: error);
        return const Center(child: Text("Error fetching trending recipes."));
      },
      data: (trendingData) {
        if (trendingData.results.isEmpty) {
          return const Center(child: Text("No trending recipes available."));
        }

        final mealItems = trendingData.results.map((recipe) {
          final imagePath = recipe.images.isNotEmpty ? recipe.images.first : '';
          final fullImageUrl = imagePath.isNotEmpty
              ? "$imageBaseUrl$imagePath"
              : "https://via.placeholder.com/400";

          return CarouselItems(
            id: recipe.id,
            imageUrls: fullImageUrl,
            title: recipe.name,
            duration: recipe.totalTime,
            description: recipe.description?.toString() ?? recipe.slug,
          );
        }).toList();

        return CarouselSliderWidget(
          items: mealItems,
          onTap: (tappedItem) {
            Logger().i(
              "Tapped on a trending recipe: ${tappedItem.title} \n ID :${tappedItem.id}",
            );
            context.push("/recipes/${tappedItem.id}");
          },
        );
      },
    );
  }
}
