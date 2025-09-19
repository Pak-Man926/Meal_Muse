import "package:flutter/material.dart";

class CategoriesButton extends StatelessWidget {
  final Icon icon;
  final String title;

  const CategoriesButton({
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
