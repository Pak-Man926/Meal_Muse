import "package:flutter/material.dart";

class CategoriesButton extends StatelessWidget {
  final Icon icon;
  final String title;
  final VoidCallback? onPressed;

  const CategoriesButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
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
