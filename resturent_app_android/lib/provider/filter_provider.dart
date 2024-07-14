import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/meal_provider.dart';

enum Filter { glutenFree, lactosFree, vegeterian, vegan }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactosFree: false,
          Filter.vegeterian: false,
          Filter.vegan: false,
        });

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setFilters(Map<Filter, bool> choosentFilter) {
    state = choosentFilter;
  }
}

final flterNotifierProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) => FilterNotifier(),
);

//

// class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
//   FilterNotifier()
//       : super({
//           Filter.glutenFree: false,
//           Filter.lactosFree: false,
//           Filter.vegeterian: false,
//           Filter.vegan: false,
//         });

//   void setFilter(Filter filter, bool isActive) {
//     state = {...state, filter: isActive};
//   }
// }

// final filterNotifierProvider =
//     StateNotifierProvider<FilterNotifier, Map<Filter, bool>>((ref) {
//   return FilterNotifier();
// });
final filteredMealsProvider = Provider(
  (ref) {
    final meals = ref.watch(mealProvider);
    final activeFilter = ref.read(flterNotifierProvider);
    return meals.where(
      (meal) {
        if (activeFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
          return false;
        }
        if (activeFilter[Filter.lactosFree]! && !meal.isLactoseFree) {
          return false;
        }
        if (activeFilter[Filter.vegeterian]! && !meal.isVegetarian) {
          return false;
        }
        if (activeFilter[Filter.vegan]! && !meal.isVegan) {
          return false;
        }
        return true;
      },
    ).toList();
  },
);
