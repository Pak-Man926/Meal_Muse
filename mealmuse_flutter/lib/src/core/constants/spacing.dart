import "package:material_ui/material_ui.dart";

class Spacing extends SizedBox {
  const Spacing.vertical(double height, {super.key}) : super(height: height);

  const Spacing.horizontal(double width, {super.key}) : super(width: width);
}
