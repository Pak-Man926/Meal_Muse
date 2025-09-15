import "package:flutter/material.dart";
import "package:mealmuse_flutter/widgets/carousel_slider_widget.dart";
//import "package:google_fonts/google_fonts.dart";
//import "package:mealmuse_flutter/widgets/image_card_widget.dart";


class HomeScreen extends StatelessWidget
{
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context)
  {
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
              CarouselSliderWidget(),
              
          ]
        ),
      ),
    );
  }

}