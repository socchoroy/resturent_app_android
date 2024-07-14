import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/model/meal.dart';

class FavouriteMealsNotifer extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifer() : super([]);

  bool toggleMealFavourite(Meal meal) {
    final mealIsFavourite = state.contains(meal);
    if (mealIsFavourite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealProbder =
    StateNotifierProvider<FavouriteMealsNotifer, List<Meal>>((ref) {
  return FavouriteMealsNotifer();
});
