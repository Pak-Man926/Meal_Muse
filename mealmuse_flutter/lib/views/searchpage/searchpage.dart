
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget{
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          )),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.tune, size: 15),
          ),
        ],
      ),
    );
  }
}