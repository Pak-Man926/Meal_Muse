import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/savedpage_controller.dart';

class SavedpageView extends GetView<SavedpageController> {
  const SavedpageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SavedpageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SavedpageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
