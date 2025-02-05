import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:meals/widgets/meal_item_trait.dart';

class MealItem extends StatelessWidget {
  const MealItem({required this.onSelectedMeal, required this.meal, super.key});

  final Meal meal;
  final void Function(Meal meal) onSelectedMeal;

  String get complexityText {
    return meal.complexity.name[0] + meal.complexity.name.substring(1);
  }

  String get affordibilityText {
    return meal.affordability.name[0] + meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          onSelectedMeal(meal);
        },
        child: Stack(children: [
          Hero(
            tag: meal.id,
            child: FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
              child: Column(
                children: [
                  Text(
                    meal.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MealItemTrait(
                          icon: Icons.schedule, label: '${meal.duration} min'),
                      SizedBox(width: 12),
                      MealItemTrait(
                        icon: Icons.work,
                        label: complexityText,
                      ),
                      SizedBox(width: 12),
                      MealItemTrait(
                        icon: Icons.attach_money,
                        label: affordibilityText,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
