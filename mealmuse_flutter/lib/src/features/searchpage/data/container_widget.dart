import "package:flutter/material.dart";

class ContainerWidget extends StatelessWidget {
  final String label;

  const ContainerWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      //alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label),
    );
  }
}
