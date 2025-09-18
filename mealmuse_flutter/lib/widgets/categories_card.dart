import "package:flutter/material.dart";

class CategoriesCard extends StatelessWidget {
  final Icon icon;
  final String title;
  final Function ontap;

  const CategoriesCard({
    super.key,
    required this.icon,
    required this.title,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: Theme.of(context).textTheme.labelMedium,
          textDirection: TextDirection.ltr,
        ),
        onTap: () => ontap,
      ),
    );
  }
}
