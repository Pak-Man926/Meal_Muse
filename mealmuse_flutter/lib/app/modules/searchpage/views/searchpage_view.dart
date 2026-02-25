import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/searchpage_controller.dart';

class SearchpageView extends GetView<SearchpageController> {
  const SearchpageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SearchpageView'),
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
