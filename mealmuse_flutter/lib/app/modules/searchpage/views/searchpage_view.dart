import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mealmuse_flutter/app/themes/text_styles.dart';

import '../controllers/searchpage_controller.dart';

class SearchpageView extends GetView<SearchpageController> {
  const SearchpageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search',style: AppTextStyles.headingsText),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SearchpageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
