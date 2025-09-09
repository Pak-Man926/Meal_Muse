import "package:flutter/material.dart";

class BottomNavigationBar extends StatelessWidget
{
  final int currentIndex;
  final Function(int) onTap;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final List<BottomNavigationBarItem>? items;

  const BottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.items,
  });

  @override
  Widget build(BuildContext context)
  {
    final theme = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      //type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: theme.primary,
      unselectedItemColor: theme.onSurface.withOpacity(0.6),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), label: "Schedule"),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline_rounded), label: "Saved"),
      ],
    );
  }
}