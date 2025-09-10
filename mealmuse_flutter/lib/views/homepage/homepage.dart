import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";


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
              style: Theme.of(context).textTheme.displayMedium)
          ]
        ),
      ),
    );
  }

}