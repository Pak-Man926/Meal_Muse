import "package:flutter/material.dart";
import "package:get/get.dart";

class SettingsPage extends StatelessWidget
{
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back,
          icon: Icon(Icons.arrow_back_rounded),
          iconSize: 24,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        centerTitle: true,
        title: Text("Settings",
          style: Theme.of(context).textTheme.displayLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Preferences",
              style: Theme.of(context).textTheme.displayMedium
            ),
            SizedBox(height: 5),
            
          ],),
      )
    );
  }
}