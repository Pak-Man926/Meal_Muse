import "package:flutter/material.dart";

class TuneIconButtonWidget extends StatelessWidget
{
  final VoidCallback onPressed;
  final double iconSize;
  //final Color color;

  const TuneIconButtonWidget({
    Key? key,
    required this.onPressed,
    this.iconSize = 24.0,
    //this.color = Color.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.tune_rounded),
      iconSize: iconSize,
      onPressed: onPressed,
    );
  }
}