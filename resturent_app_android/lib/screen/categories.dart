import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screen/meals.dart';
import 'package:meals/widgets/categories_grid_item.dart';
import 'package:meals/model/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({required this.availableMeals, super.key});

  // final void Function(Meal meal) onToogleFavourite;
  final List<Meal> availableMeals;

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
      duration: Duration(milliseconds: 300),
      upperBound: 1,
      lowerBound: 0,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _selectedScreen(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList(); //here dummyMeal
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            for (final category in availableCategories)
              CategoriesGridItem(
                category: category,
                onSelectedCategory: () {
                  _selectedScreen(context, category);
                },
              )
          ],
        ),
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: Offset(0, 0.3),
          end: Offset(0, 0),
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        )),
        child: child,
      ),
    );
  }
}
