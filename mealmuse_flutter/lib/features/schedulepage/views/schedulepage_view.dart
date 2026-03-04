import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/schedulepage_controller.dart';

class SchedulepageView extends GetView<SchedulepageController> {
  const SchedulepageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SchedulepageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SchedulepageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
