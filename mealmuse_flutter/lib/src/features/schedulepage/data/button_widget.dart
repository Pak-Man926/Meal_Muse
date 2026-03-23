
import "package:flutter/material.dart";

import "../../../core/themes/colors.dart";


class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? color;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color = const Color.fromARGB(255, 220, 226, 233),
    this.textStyle,
  });

  const CustomButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.color = AppColors.primary,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            text,
            style: textStyle,
          ),
        ));
  }
}