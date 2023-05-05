enum Complexity {
  simple,
  challenging,
  hard;

  String get complexityText {
    //Make name lowercase and make first letter uppercase
    return toString().split('.').last[0].toUpperCase() +
        toString().split('.').last.substring(1);
  }
}

enum Affordability {
  affordable,
  pricey,
  luxurious;

  String get affordabilityText {
    //Make name lowercase and make first letter uppercase
    return toString().split('.').last[0].toUpperCase() +
        toString().split('.').last.substring(1);
  }
}

class Meal {
  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });

  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;
}
