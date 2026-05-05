import "package:flutter/material.dart";
import "package:carousel_slider/carousel_slider.dart";
import "package:meal_muse/src/core/constants/constants.dart";

import "package:meal_muse/src/core/themes/colors.dart";
import "package:meal_muse/src/core/themes/text_styles.dart";
import "package:meal_muse/src/features/home/domain/carousel_items.dart";

class CarouselSliderWidget extends StatelessWidget {
  final List<CarouselItems> items;

  const CarouselSliderWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CarouselSlider(
      options: CarouselOptions(
        height: 350,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        scrollDirection: Axis.horizontal,
      ),
      items: items.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(item.imageUrls, fit: BoxFit.cover),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: theme.textTheme.headlineMedium),
                      tinySpaceSize,
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_filled_rounded,
                            size: 16,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            "${item.duration} mins",
                            style: theme.textTheme.labelMedium,
                          ),
                        ],
                      ),
                      Text(
                        item.description,
                        style: theme.textTheme.labelMedium,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textScaleFactor: 1.0,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      }).toList(),
    );
  }
}
