
import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget
{
  const ScheduleScreen({super.key});
  
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule",
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