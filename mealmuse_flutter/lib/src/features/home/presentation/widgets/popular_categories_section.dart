import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_muse/src/features/home/data/recipe_categories_repository.dart';
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

        return Expanded(
          child: GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.2,
            children: categories.map((category) {
              return CategoriesButton(
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
                  // String routeName = category.name.toLowerCase();
                  // String routePath = "";
                  // if (routeName == 'baked foods') {
                  //   routePath = "/bakedrecipes";
                  // } else {
                  //   if ([
                  //     'drinks',
                  //     'desserts',
                  //     'soups',
                  //     'snacks',
                  //   ].contains(routeName)) {
                  //     routePath =
                  //         "/${routeName.substring(0, routeName.length - 1)}recipes";
                  //   } else {
                  //     routePath = "/${routeName.replaceAll(' ', '')}recipes";
                  //   }
                  // }
                  // context.push(routePath, extra: category.id);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
