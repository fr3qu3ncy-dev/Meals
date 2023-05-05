import 'package:flutter/material.dart';
import 'package:meals/widgets/meal_item.dart';

import '../models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({this.title, required this.meals, Key? key})
      : super(key: key);

  final String? title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    final content = meals.isEmpty
        ? Center(
            child: Text('No meals found.\nTry adding some!',
                style: Theme.of(context).textTheme.bodyLarge),
          )
        : ListView.builder(
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];
              return MealItem(
                meal,
              );
            },
          );

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
