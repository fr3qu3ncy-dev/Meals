import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/category.dart';
import 'package:meals/providers/meal_filters_provider.dart';
import 'package:meals/screens/meals_screen.dart';

import '../models/meal.dart';

class CategoryGridItem extends ConsumerWidget {
  const CategoryGridItem(this.category, {Key? key})
      : super(key: key);

  final Category category;

  List<Meal> _getMeals(Category category, WidgetRef ref) {
    return ref.watch(filteredMealsProvider).where((meal) {
      return meal.categories.contains(category.id);
    }).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
        //Switch to MealsScreen when tapped
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MealsScreen(
                title: category.title,
                meals: _getMeals(category, ref),
              ),
            ),
          );
        },
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        splashColor: Theme.of(context).primaryColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [
                category.color.withOpacity(0.7),
                category.color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Text(
              category.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      );
  }
}
