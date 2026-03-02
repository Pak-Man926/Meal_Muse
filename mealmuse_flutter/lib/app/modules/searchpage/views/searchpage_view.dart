import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:meal_muse/utils/constants.dart';

import '../../../../themes/text_styles.dart';
import '../controllers/searchpage_controller.dart';

class SearchpageView extends GetView<SearchpageController> {
  const SearchpageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search', style: AppTextStyles.headingsText),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  mediumSpaceSize,
                  Icon(Icons.search, size: 30, color: Colors.grey),
                  smallSpaceSize,
                  Text("Search for recipes, ingredients, or categories",
                      style: AppTextStyles.bodyText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
