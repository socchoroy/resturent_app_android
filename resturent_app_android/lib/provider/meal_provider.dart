import 'package:meals/data/dummy_data.dart';
import 'package:riverpod/riverpod.dart';

final mealProvider = Provider((ref) {
  return dummyMeals;
});
