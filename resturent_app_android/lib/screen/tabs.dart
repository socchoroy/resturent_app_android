import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screen/categories.dart';
import 'package:meals/screen/filters.dart';
import 'package:meals/screen/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

Map<Filter, bool> kInitFilters = {
  Filter.glutenFree: false,
  Filter.lactosFree: false,
  Filter.vegeterian: false,
  Filter.vegan: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Meal> favouriteMeal = [];
  Map<Filter, bool> _selectedFilter = kInitFilters;

  void _showInfoMesseges(String messeges) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(messeges),
      ),
    );
  }

  void _toggleMealFavourite(Meal meal) {
    bool isExist = favouriteMeal.contains(meal);

    if (isExist == true) {
      setState(() {
        favouriteMeal.remove(meal);
        _showInfoMesseges("Removed From Favourite");
      });
    } else {
      setState(() {
        favouriteMeal.add(meal);
        _showInfoMesseges("Marked as a Favourite");
      });
    }
  }

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      final result = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilters: _selectedFilter),
        ),
      );

      _selectedFilter = result ?? kInitFilters;
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where(
      (meal) {
        if (_selectedFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
          return false;
        }
        if (_selectedFilter[Filter.lactosFree]! && !meal.isLactoseFree) {
          return false;
        }
        if (_selectedFilter[Filter.vegeterian]! && !meal.isVegetarian) {
          return false;
        }
        if (_selectedFilter[Filter.vegan]! && !meal.isVegan) {
          return false;
        }
        return true;
      },
    ).toList();

    Widget activePage = CategoriesScreen(
      onToogleFavourite: _toggleMealFavourite,
      availableMeals: availableMeals,
    );
    var activePageTitle = "Categories";
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: favouriteMeal,
        onToogleFavourite: _toggleMealFavourite,
      );
      activePageTitle = "Your Favourite";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      drawer: MainDrawer(onSelectedScreen: _setScreen),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favourite",
          )
        ],
      ),
    );
  }
}
