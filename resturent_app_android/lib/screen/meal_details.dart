import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/provider/favourite_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({required this.meal, super.key});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeal = ref.watch(favouriteMealProbder);
    final isFavourite = favouriteMeal.contains(meal);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          meal.title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favouriteMealProbder.notifier)
                  .toggleMealFavourite(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded
                      ? "Meals Marked As Favourite"
                      : "Meals Removed From Favourite"),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(microseconds: 300),
              transitionBuilder: (child, animation) => RotationTransition(
                turns: Tween<double>(begin: 0.8, end: 1).animate(animation),
                child: child,
              ),
              switchInCurve: Curves.bounceIn,
              switchOutCurve: Curves.bounceInOut,
              child: Icon(isFavourite ? Icons.star : Icons.star_border),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Hero(
            tag: meal.id,
            child: Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            "Ingredients",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 14),
          for (final ingredient in meal.ingredients)
            Text(
              ingredient,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          SizedBox(
            height: 24,
          ),
          Text(
            "Steps",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 14),
          for (final steps in meal.steps)
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              child: Text(
                steps,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
        ]),
      ),
    );
  }
}
