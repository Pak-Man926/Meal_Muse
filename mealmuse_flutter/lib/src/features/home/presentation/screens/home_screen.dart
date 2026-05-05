import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_muse/src/core/constants/constants.dart';
import 'package:meal_muse/src/features/home/domain/carousel_items.dart';
import 'package:meal_muse/src/features/home/presentation/widgets/carousel_slider_widget.dart';
import 'package:meal_muse/src/features/home/presentation/widgets/categories_button.dart';
import 'package:meal_muse/src/features/home/presentation/widgets/tune_icon_button_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<CarouselItems> mealItems = [
      CarouselItems(
        imageUrls:
            "https://www.themealdb.com/images/media/meals/58oia61564916529.jpg",
        title: "Beef and Mustard Pie",
        duration: 20,
        description: "A delicious beef and mustard pie recipe.",
      ),
      CarouselItems(
        imageUrls:
            "https://www.themealdb.com/images/media/meals/vvpprx1487325699.jpg",
        title: "Chicken Handi",
        duration: 45,
        description: "A flavorful chicken handi recipe.",
      ),
      CarouselItems(
        imageUrls:
            "https://www.themealdb.com/images/media/meals/wyxwsp1486979827.jpg",
        title: "Chickpea Fajitas",
        duration: 75,
        description: "A tasty chickpea fajitas recipe.",
      ),
      CarouselItems(
        imageUrls:
            "https://www.themealdb.com/images/media/meals/1529444830.jpg",
        title: "Lamb Biryani",
        duration: 55,
        description: "A spicy lamb biryani recipe.",
      ),
      CarouselItems(
        imageUrls:
            "https://www.themealdb.com/images/media/meals/1548772327.jpg",
        title: "Pork and Apple Burgers",
        duration: 35,
        description: "A juicy pork and apple burgers recipe.",
      ),
    ];
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
              mainAxisAlignment: .spaceBetween,
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
            CarouselSliderWidget(items: mealItems),
            minSpaceSize,
            Text("Popular Categories", style: theme.textTheme.headlineMedium),
            mediumSpaceSize,
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1.2,
                children: [
                  CategoriesButton(
                    icon: Icons.free_breakfast_rounded,
                    title: "Breakfast",
                    onPressed: () {
                      context.push("/breakfastrecipes");
                    },
                  ),
                  CategoriesButton(
                    icon: Icons.lunch_dining_rounded,
                    title: "Lunch",
                    onPressed: () {
                      context.push("/lunchrecipes");
                    },
                  ),
                  CategoriesButton(
                    icon: Icons.dinner_dining_rounded,
                    title: "Dinner",
                    onPressed: () {
                      context.push("/dinnerrecipes");
                    },
                  ),
                  CategoriesButton(
                    icon: Icons.wine_bar_rounded,
                    title: "Drinks",
                    onPressed: () {
                      context.push("/drinkrecipes");
                    },
                  ),
                  CategoriesButton(
                    icon: Icons.icecream,
                    title: "Desserts",
                    onPressed: () {
                      context.push("/dessertrecipes");
                    },
                  ),
                  CategoriesButton(
                    icon: Icons.soup_kitchen_rounded,
                    title: "Soups",
                    onPressed: () {
                      context.push("/souprecipes");
                    },
                  ),
                  CategoriesButton(
                    icon: Icons.restaurant,
                    title: "Snacks",
                    onPressed: () {
                      context.push("/snackrecipes");
                    },
                  ),
                  CategoriesButton(
                    icon: Icons.bakery_dining_rounded,
                    title: "Baked Foods",
                    onPressed: () {
                      context.push("/bakedrecipes");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
