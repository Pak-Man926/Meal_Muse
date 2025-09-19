import "package:flutter/material.dart";
import "package:carousel_slider/carousel_slider.dart";
import "package:mealmuse_flutter/models/carousel_items.dart";

class CarouselSliderWidget extends StatelessWidget
{
    final List<CarouselItems> items;

    CarouselSliderWidget({
    super.key,
    required this.items,
    });

  @override
  Widget build(BuildContext context)
  {
      return CarouselSlider(
        options: CarouselOptions(
          height: 470,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay:true,
          autoPlayInterval: Duration(seconds:3),
          scrollDirection: Axis.horizontal,
          ),
        items: items.map((item)
        {
          return Builder(
            builder: (BuildContext context)
            {
              return Column(
                children: <Widget>[
                  Container(
                    width: 350,
                    height: 350,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.black, 
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        item.imageUrls,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          item.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ]
                    )
                  ),
                ]
              );
            }
          );
        }).toList(),
      );
  }
}