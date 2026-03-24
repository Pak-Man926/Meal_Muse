class Recipe {
  final String? mealType;
  final String meal;
  final int prepTime;
  final int composition;
  final String imageAddress;

  Recipe({
    this.mealType,
    required this.meal,
    required this.prepTime,
    required this.composition,
    required this.imageAddress,
  });
}
