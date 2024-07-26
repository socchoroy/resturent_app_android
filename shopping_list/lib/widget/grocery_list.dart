import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
// import 'package:shopping_list/data/dummy_item.dart';
import 'dart:convert';
// import 'package:shopping_list/model/category.dart';
// import 'package:shopping_list/data/dummy_item.dart';
import 'package:shopping_list/model/grocery_item.dart';
import 'package:shopping_list/widget/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItem = [];
  var _isLoading = true;
  String? _error;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    try {
      final url = Uri.https('shopping-list-6ad20-default-rtdb.firebaseio.com',
          'shopping-list.json');
      final response = await http.get(url);
      final responseCode = response.statusCode;
      final Map<String, dynamic> listInfo = json.decode(response.body);

      if (responseCode >= 400) {
        setState(() {
          _error = "Failed to fetch data please try again later";
        });
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final List<GroceryItem> _loadedItem = [];

      for (final item in listInfo.entries) {
        final category = categories.entries
            .firstWhere(
              (element) => element.value.title == item.value['category'],
            )
            .value;
        _loadedItem.add(GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['qunatity'],
            category: category));
      }

      setState(() {
        _groceryItem = _loadedItem;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = "Something went wrong! please try again later";
      });
    }
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItem.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) async {
    setState(() {
      _groceryItem.remove(item);
    });

    var index = _groceryItem.indexOf(item);
    final url = Uri.https('shopping-list-6ad20-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      const SnackBar(
        content: Text('Sorry Something went Wrong please try again later'),
      );
      setState(() {
        _groceryItem.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("You nothing add yet "),
    );

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_groceryItem.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItem.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(_groceryItem[index].id),
            onDismissed: (direction) {
              _removeItem(_groceryItem[index]);
            },
            child: ListTile(
              title: Text(
                _groceryItem[index].name,
              ),
              leading: Container(
                width: 24,
                height: 24,
                color: _groceryItem[index].category.color,
              ),
              trailing: Text(
                _groceryItem[index].quantity.toString(),
              ),
            ),
          );
        },
      );
    }

    if (_error != null) {
      Center(
        child: Text(_error!),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: content,
    );
  }
}
