import "package:flutter/material.dart";
import "package:carousel_slider/carousel_slider.dart";

class CarouselSliderWidget extends StatelessWidget
{
    CarouselSliderWidget({
    super.key,
    //required this.imageUrls,
    });

   final List<String> imageUrls = [
    'https://picsum.photos/300/450?1',
    'https://picsum.photos/300/450?2',
    'https://picsum.photos/300/450?3',
    'https://picsum.photos/300/450?4',
    'https://picsum.photos/300/450?5',
    'https://picsum.photos/300/450?6',
  ];

  @override
  Widget build(BuildContext context)
  {
      return CarouselSlider(
        options: CarouselOptions(
          height: 500,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay:true,
          autoPlayInterval: Duration(seconds:3),
          scrollDirection: Axis.horizontal,
          ),
        items: imageUrls.map((url)
        {
          return Builder(
            builder: (BuildContext context)
            {
              return Container(
                width: 300,
                height: 450,
                margin: const EdgeInsets.symmetric(horizontal:5.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace)
                  {
                    return const Center(
                      child: Icon(Icons.error),
                    );
                  },
                ), 
              );
            }
          );
        }).toList(),
      );
  }
}