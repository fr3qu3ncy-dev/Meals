import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
        child: GridView(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 13,
              mainAxisSpacing: 13),
          children: availableCategories
              .map((category) => CategoryGridItem(category))
              .toList(),
        ),
      ),
      builder: (context, child) => SlideTransition(
          position: Tween(
            begin: const Offset(0, 0.75),
            end: const Offset(0, 0),
          ).animate(CurvedAnimation(
              parent: _animationController, curve: Curves.easeInOut)),
          child: child),
    );
  }
}
