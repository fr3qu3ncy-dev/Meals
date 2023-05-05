import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/filters_screen.dart';

import '../models/meal.dart';

class MealFiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  MealFiltersNotifier() : super({});

  toggleFilter(Filter filter) {
    state = {...state, filter: !(state[filter] ?? false)};
  }

  bool isFiltered(Filter filter) {
    return state[filter] ?? false;
  }
}

final mealFiltersProvider =
    StateNotifierProvider<MealFiltersNotifier, Map<Filter, bool>>(
        (ref) => MealFiltersNotifier());

final filteredMealsProvider = Provider<List<Meal>>((ref) {
  ref.watch(mealFiltersProvider);
  final notifier = ref.read(mealFiltersProvider.notifier);
  final meals = ref.read(mealsProvider);

  return meals
      .where((meal) =>
          (!notifier.isFiltered(Filter.glutenFree) || meal.isGlutenFree) &&
          (!notifier.isFiltered(Filter.vegetarian) || meal.isVegetarian) &&
          (!notifier.isFiltered(Filter.vegan) || meal.isVegan) &&
          (!notifier.isFiltered(Filter.lactoseFree) || meal.isLactoseFree))
      .toList();
});
