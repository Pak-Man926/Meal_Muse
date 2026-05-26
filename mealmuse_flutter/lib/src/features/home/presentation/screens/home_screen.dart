import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_muse/src/core/constants/constants.dart';
import 'package:meal_muse/src/features/home/presentation/widgets/popular_categories_section.dart';
import 'package:meal_muse/src/features/home/presentation/widgets/trending_recipes_section.dart';
import 'package:meal_muse/src/features/home/presentation/widgets/tune_icon_button_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Meal Muse", style: theme.textTheme.titleLarge),
        actions: [
          TuneIconButtonWidget(
            onPressed: () {
              context.push("/settings");
            },
            iconSize: 30,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Trending Recipes", style: theme.textTheme.headlineMedium),
                TextButton(
                  onPressed: () {
                    context.push("/trendingrecipes");
                  },
                  child: Text(
                    "See All",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            mediumSpaceSize,
            const TrendingRecipesSection(),
            minSpaceSize,
            Text("Popular Categories", style: theme.textTheme.headlineMedium),
            mediumSpaceSize,
            const PopularCategoriesSection(),
          ],
        ),
      ),
    );
  }
}
