import "package:flutter/material.dart";

class CategoriesCard extends StatelessWidget {
  final Icon icon;
  final String title;

  const CategoriesCard({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 100,
      child: OutlinedButton(
        onPressed: null,
        child: Row(
          children: [
            icon,
            SizedBox(width: 5),
            Text(title, style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        
      )
    );
  }
}
