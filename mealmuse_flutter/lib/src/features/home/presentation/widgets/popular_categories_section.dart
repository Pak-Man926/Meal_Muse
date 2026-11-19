import "package:material_ui/material_ui.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_muse/src/features/home/data/recipe_categories_repository.dart';
import 'package:meal_muse/src/features/home/domain/recipe_categories_model.dart';
import 'package:meal_muse/src/core/constants/spacing.dart';
import 'package:meal_muse/src/features/home/presentation/widgets/categories_button.dart';

class PopularCategoriesSection extends ConsumerWidget {
  const PopularCategoriesSection({super.key});

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'breakfast':
        return Icons.free_breakfast_rounded;
      case 'lunch':
        return Icons.lunch_dining_rounded;
      case 'dinner':
        return Icons.dinner_dining_rounded;
      case 'drinks':
        return Icons.wine_bar_rounded;
      case 'desserts':
        return Icons.icecream;
      case 'soups':
        return Icons.soup_kitchen_rounded;
      case 'snacks':
        return Icons.restaurant;
      case 'baked foods':
        return Icons.bakery_dining_rounded;
      default:
        return Icons.fastfood_rounded;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesModule = ref.watch(apiRecipeCategoriesProvider);

    return categoriesModule.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) =>
          const Center(child: Text("Error fetching categories")),
      data: (categories) {
        if (categories.isEmpty) {
          return const Center(child: Text("No categories available."));
        }

        const int crossAxisCount = 4;
        final List<List<RecipeCategories>> rows = [];
        for (var i = 0; i < categories.length; i += crossAxisCount) {
          rows.add(
            categories.sublist(
              i,
              i + crossAxisCount > categories.length
                  ? categories.length
                  : i + crossAxisCount,
            ),
          );
        }

        return Column(
          children: [
            for (int rowIndex = 0; rowIndex < rows.length; rowIndex++) ...[
              if (rowIndex > 0) Spacing.vertical(14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final category in rows[rowIndex])
                    Expanded(
                      child: CategoriesButton(
                        icon: _getCategoryIcon(category.name),
                        title: category.name,
                        onPressed: () {
                          logger.i(
                            "Tapped on category: ${category.name} with ID: ${category.id}",
                          );

                          context.push(
                            "/${category.name.toLowerCase().replaceAll(' ', '')}",
                            extra: category.id,
                          );
                        },
                      ),
                    ),
                  for (
                    int i = 0;
                    i < crossAxisCount - rows[rowIndex].length;
                    i++
                  )
                    const Expanded(child: SizedBox()),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
