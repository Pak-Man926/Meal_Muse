import "package:flutter/material.dart";

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Muse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Meal Muse'),
        ),
        body: Center(
          child: Text('Welcome to Meal Muse!'),
        ),
      ),
    );
  }
}