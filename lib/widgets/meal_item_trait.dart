import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait(this.icon, this.label, {Key? key}) : super(key: key);

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 5),
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
