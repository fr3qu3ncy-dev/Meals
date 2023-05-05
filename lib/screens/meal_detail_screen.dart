import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen(this.meal, {Key? key}) : super(key: key);

  final Meal meal;

  //Toggle favorite status using the provider
  void _onToggleFavorite(Meal meal, WidgetRef ref, BuildContext context) {
    final wasRemoved =
        ref.read(favoriteMealsProvider.notifier).toggleFavorite(meal);
    final message = wasRemoved
        ? 'Removed ${meal.title} from favorites'
        : 'Added ${meal.title} to favorites';
    _showInfoMessage(message, context);
  }

  _showInfoMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoriteMealsProvider).contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(meal.title),
        ),
        actions: [
          IconButton(
            onPressed: () => _onToggleFavorite(meal, ref, context),
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => RotationTransition(
                  turns: Tween(begin: 0.8, end: 1.0).animate(animation),
                  child: child),
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavorite),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
              ),
            ),
            const SizedBox(height: 10),
            _buildSectionTitle(context, "Ingredients"),
            const SizedBox(height: 10),
            _buildSectionDescription(context, meal.ingredients),
            const SizedBox(height: 20),
            _buildSectionTitle(context, "Steps"),
            const SizedBox(height: 10),
            _buildSectionDescriptionWithNumbers(context, meal.steps),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style:
          TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.primary),
    );
  }

  Widget _buildSectionDescription(BuildContext context, List<String> items) {
    return Column(
      children: items.map((ingredient) {
        return Text(
          ingredient,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
        );
      }).toList(),
    );
  }

  //Create a widget that displays the meal's steps with a number in front of each step.
  Widget _buildSectionDescriptionWithNumbers(
      BuildContext context, List<String> items) {
    return Column(
      children: items.asMap().entries.map((entry) {
        final index = entry.key + 1;
        final ingredient = entry.value;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 14,
                child: Text(
                  '$index',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(width: 15),
              Flexible(
                child: Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 15),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
