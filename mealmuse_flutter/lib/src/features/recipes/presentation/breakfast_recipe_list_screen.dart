import "package:flutter/material.dart";

import "../../../core/themes/text_styles.dart";

class BreakfastRecipeListScreen extends StatelessWidget {
  const BreakfastRecipeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Breakfast", style: AppTextStyles.pageTitle),
        centerTitle: true,
      ),
      //body: 
    );
  }
}
