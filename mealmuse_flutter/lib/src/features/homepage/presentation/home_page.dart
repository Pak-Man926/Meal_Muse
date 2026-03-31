import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/constants.dart';
import '../../../core/themes/text_styles.dart';
import '../data/carousel_items.dart';
import '../data/carousel_slider_widget.dart';
import '../data/categories_button.dart';
import '../data/tune_icon_button_widget.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<CarouselItems> mealItems = [
      CarouselItems(
        imageUrls:
            "https://www.themealdb.com/images/media/meals/58oia61564916529.jpg",
        title: "Beef and Mustard Pie",
        description: "A delicious beef and mustard pie recipe.",
      ),
      CarouselItems(
        imageUrls:
            "https://www.themealdb.com/images/media/meals/vvpprx1487325699.jpg",
        title: "Chicken Handi",
        description: "A flavorful chicken handi recipe.",
      ),
      CarouselItems(
        imageUrls:
            "https://www.themealdb.com/images/media/meals/wyxwsp1486979827.jpg",
        title: "Chickpea Fajitas",
        description: "A tasty chickpea fajitas recipe.",
      ),
      CarouselItems(
        imageUrls:
            "https://www.themealdb.com/images/media/meals/1529444830.jpg",
        title: "Lamb Biryani",
        description: "A spicy lamb biryani recipe.",
      ),
      CarouselItems(
        imageUrls:
            "https://www.themealdb.com/images/media/meals/1548772327.jpg",
        title: "Pork and Apple Burgers",
        description: "A juicy pork and apple burgers recipe.",
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Meal Muse", style: AppTextStyles.headingsText),
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
            Text("Trending Recipes", style: AppTextStyles.subHeadingsText),
            mediumSpaceSize,
            CarouselSliderWidget(items: mealItems),
            minSpaceSize,
            Text("Popular Categories", style: AppTextStyles.subHeadingsText),
            smallSpaceSize,
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 5.0,
                children: [
                  CategoriesButton(
                    icon: Icon(
                      Icons.free_breakfast_rounded,
                      color: theme.colorScheme.onSurface,
                    ),
                    title: "Breakfast",
                    onPressed: () {
                      context.push("/items");
                    },
                  ),
                  CategoriesButton(
                    icon: Icon(
                      Icons.lunch_dining_rounded,
                      color: theme.colorScheme.onSurface,
                    ),
                    title: "Lunch",
                    onPressed: () {
                      context.push("/items");
                    },
                  ),
                  CategoriesButton(
                    icon: Icon(
                      Icons.dinner_dining_rounded,
                      color: theme.colorScheme.onSurface,
                    ),
                    title: "Dinner",
                    onPressed: () {
                      context.push("/items");
                    },
                  ),
                  CategoriesButton(
                    icon: Icon(
                      Icons.wine_bar_rounded,
                      color: theme.colorScheme.onSurface,
                    ),
                    title: "Drinks",
                    onPressed: () {
                      context.push("/items");
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
