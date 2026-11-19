import "package:material_ui/material_ui.dart";

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  static Size screenSize(BuildContext context) => MediaQuery.of(context).size;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double safeHeight(BuildContext context) =>
      screenHeight(context) -
      (MediaQuery.of(context).padding.top) - // Notch area and status bar
      (MediaQuery.of(context).padding.bottom); // Botton Nav area

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  /// Returns responsive padding based on screen size
  /// Mobile: 16, Tablet: 24, Desktop: 32
  static double getResponsivePadding(BuildContext context) {
    if (isDesktop(context)) return 32.0;
    if (isTablet(context)) return 24.0;
    return 16.0;
  }

  /// Returns responsive font size based on screen size
  /// Scales the base font size by screen type
  static double getResponsiveFontSize(
    BuildContext context,
    double baseFontSize,
  ) {
    if (isDesktop(context)) return baseFontSize * 1.2;
    if (isTablet(context)) return baseFontSize * 1.1;
    return baseFontSize;
  }

  /// Returns max content width for centered layouts on larger screens
  /// Mobile: full width, Tablet: 1000px, Desktop: 1200px
  static double getMaxContentWidth(BuildContext context) {
    if (isDesktop(context)) return 1200.0;
    if (isTablet(context)) return 1000.0;
    return screenWidth(context);
  }

  /// Returns responsive spacing based on screen size
  /// Mobile: 8, Tablet: 12, Desktop: 16
  static double getResponsiveSpacing(BuildContext context) {
    if (isDesktop(context)) return 16.0;
    if (isTablet(context)) return 12.0;
    return 8.0;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200) {
          return desktop;
        } else if (constraints.maxWidth >= 800) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}