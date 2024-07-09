import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screen/categories.dart';
import 'package:meals/screen/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Meal> favouriteMeal = [];

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

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToogleFavourite: _toggleMealFavourite,
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
      drawer: MainDrawer(),
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
