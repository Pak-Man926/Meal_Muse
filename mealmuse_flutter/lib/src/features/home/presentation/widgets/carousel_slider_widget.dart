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
                Container(
                  width: double.infinity,
                  height: 250,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: AppColors.charcoal,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(item.imageUrls, fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: AppTextStyles.sectionHeader),
                      tinySpaceSize,
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_filled_rounded,
                            size: 16,
                            color: AppColors.mutedText,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            "${item.duration} mins",
                            style: AppTextStyles.labelMuted,
                          ),
                        ],
                      ),
                      Text(
                        item.description,
                        style: AppTextStyles.labelMuted,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
