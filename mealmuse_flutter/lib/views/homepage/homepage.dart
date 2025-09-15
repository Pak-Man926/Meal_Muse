import "package:flutter/material.dart";
import "package:mealmuse_flutter/widgets/carousel_slider_widget.dart";
import "package:mealmuse_flutter/models/carousel_items.dart";
//import "package:google_fonts/google_fonts.dart";
//import "package:mealmuse_flutter/widgets/image_card_widget.dart";


class HomeScreen extends StatelessWidget
{
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context)
  {

    final List<CarouselItems> mealItems = [
      CarouselItems(
        imageUrls: "https://www.themealdb.com/images/media/meals/58oia61564916529.jpg",
        title: "Beef and Mustard Pie",
        description: "A delicious beef and mustard pie recipe.",
      ),
      CarouselItems(
        imageUrls: "https://www.themealdb.com/images/media/meals/vvpprx1487325699.jpg",
        title: "Chicken Handi",
        description: "A flavorful chicken handi recipe.",
      ),
      CarouselItems(
        imageUrls: "https://www.themealdb.com/images/media/meals/wyxwsp1486979827.jpg",
        title: "Chickpea Fajitas",
        description: "A tasty chickpea fajitas recipe.",
      ),
      CarouselItems(
        imageUrls: "https://www.themealdb.com/images/media/meals/1529444830.jpg",
        title: "Lamb Biryani",
        description: "A spicy lamb biryani recipe.",
      ),
      CarouselItems(
        imageUrls: "https://www.themealdb.com/images/media/meals/1548772327.jpg",
        title: "Pork and Apple Burgers",
        description: "A juicy pork and apple burgers recipe.",
      ),
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Text("Trending Recipes",
              style: Theme.of(context).textTheme.displayMedium),
              SizedBox(height:10),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children:[
              //     ImageCardWidget(
              //       onTap: ()
              //       {},
              //       ),
                    
              //   ],
              // ),
              CarouselSliderWidget(items: mealItems),

          ]
        ),
      ),
    );
  }

}