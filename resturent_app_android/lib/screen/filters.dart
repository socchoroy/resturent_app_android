import 'package:flutter/material.dart';
import 'package:meals/provider/filter_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFiler = ref.watch(flterNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filter"),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: activeFiler[Filter.glutenFree]!,
            onChanged: (isChecked) {
              ref
                  .read(flterNotifierProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
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
            value: activeFiler[Filter.lactosFree]!,
            onChanged: (isChecked) {
              ref
                  .read(flterNotifierProvider.notifier)
                  .setFilter(Filter.lactosFree, isChecked);
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
            value: activeFiler[Filter.vegeterian]!,
            onChanged: (isChecked) {
              ref
                  .read(flterNotifierProvider.notifier)
                  .setFilter(Filter.vegeterian, isChecked);
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
            value: activeFiler[Filter.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(flterNotifierProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
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
    );
  }
}
