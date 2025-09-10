
import 'package:flutter/material.dart';

class SavedScreen extends StatelessWidget
{
  const SavedScreen({super.key});
  
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Recipes"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Your saved recipes will appear here."),
      ),
    );
  }
}