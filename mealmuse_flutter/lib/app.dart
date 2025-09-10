import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:mealmuse_flutter/views/homepage/homepage.dart";
import "package:mealmuse_flutter/views/savedpage/savedpage.dart";
import "package:mealmuse_flutter/views/schedulepage/schedulepage.dart";
import "package:mealmuse_flutter/views/searchpage/searchpage.dart";

import "controllers/theme_controller.dart";
import "routes.dart";
import "themes/theme.dart";
import "widgets/tune_icon_button_widget.dart";
import "widgets/bottom_navigation_bar.dart";

class AppPage extends StatefulWidget
{
  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  //const AppPage({super.key});
  final ThemeController themeController = Get.put(ThemeController());

  int _selectedIndex = 0;

  void _onItemTapped(int index)
  {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomeScreen(),
    SearchScreen(),
    ScheduleScreen(),
    SavedScreen()
  ];

  @override
  Widget build(BuildContext context)

  {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text ("Recipe Generator",
          style: Theme.of(context).textTheme.displayLarge),
        actions: [
         TuneIconButtonWidget(
          onPressed: ()
          {

          },
          iconSize: 30,
          color: Colors.black,
         ), 
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: true,
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar:  AppBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}