import 'package:flutter/material.dart';

enum Filter { glutenFree, lactosFree, vegeterian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({required this.currentFilters, super.key});
  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactosFreeFilterSet = false;
  var _vegeterian = false;
  var _vegan = false;

  @override
  void initState() {
    super.initState();

    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactosFreeFilterSet = widget.currentFilters[Filter.lactosFree]!;
    _vegeterian = widget.currentFilters[Filter.vegeterian]!;
    _vegan = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filter"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactosFree: _lactosFreeFilterSet,
            Filter.vegan: _vegan,
            Filter.vegeterian: _vegeterian,
          });
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
              },
              activeColor: Theme.of(context).colorScheme.tertiary,
              title: Text(
                "Gluten Free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Only Include Gluteen Free Meal",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
            SwitchListTile(
              value: _lactosFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _lactosFreeFilterSet = isChecked;
                });
              },
              activeColor: Theme.of(context).colorScheme.tertiary,
              title: Text(
                "Lactose Free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Only Include Lactos Free Meal",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
            SwitchListTile(
              value: _vegeterian,
              onChanged: (isChecked) {
                setState(() {
                  _vegeterian = isChecked;
                });
              },
              activeColor: Theme.of(context).colorScheme.tertiary,
              title: Text(
                "Vegeterian",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Only Include Vegetable Meal",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
            SwitchListTile(
              value: _vegan,
              onChanged: (isChecked) {
                setState(() {
                  _vegan = isChecked;
                });
              },
              activeColor: Theme.of(context).colorScheme.tertiary,
              title: Text(
                "Vegan",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Only Include Vegan Meal",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
