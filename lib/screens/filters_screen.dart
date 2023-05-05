import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meal_filters_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(mealFiltersProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Filters")),
      body: Column(
        children: [
          _buildSwitch(
              "Gluten-free",
              "Only include gluten-free meals.",
              () => notifier.isFiltered(Filter.glutenFree),
              (value) => notifier.toggleFilter(Filter.glutenFree)),
          _buildSwitch(
              "Lactose-free",
              "Only include lactose-free meals.",
              () => notifier.isFiltered(Filter.lactoseFree),
              (value) => notifier.toggleFilter(Filter.lactoseFree)),
          _buildSwitch(
              "Vegetarian",
              "Only include vegetarian meals.",
              () => notifier.isFiltered(Filter.vegetarian),
              (value) => notifier.toggleFilter(Filter.vegetarian)),
          _buildSwitch(
              "Vegan",
              "Only include vegan meals.",
              () => notifier.isFiltered(Filter.vegan),
              (value) => notifier.toggleFilter(Filter.vegan)),
        ],
      ),
    );
  }

  Widget _buildSwitch(String title, String subTitle,
      bool Function() valueGetter, Function(bool) valueSetter) {
    return SwitchListTile(
      value: valueGetter(),
      onChanged: (value) => setState(() => valueSetter(value)),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
