import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screen/meals.dart';
import 'package:meals/widgets/categories_grid_item.dart';
import 'package:meals/model/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({required this.onToogleFavourite, super.key});

  final void Function(Meal meal) onToogleFavourite;

  void _selectedScreen(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList(); //here dummyMeal
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          onToogleFavourite: onToogleFavourite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
