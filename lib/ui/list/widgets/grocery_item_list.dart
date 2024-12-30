import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/ui/helper_func.dart';
import 'package:shopping_conv/ui/list/edit_item_screen.dart';
import 'package:shopping_conv/blocs/grocery/grocery_list_bloc.dart';

final List<Map<dynamic, dynamic>> groceryCategories = [
    {
      'items': [
        {'item':'chicken'},
        {'item':'pork'},
        {'item':'beef'},
        {'item':'lamp'},
      ],
      'category': 'Meat',
    },
    {
      'items': [
        {'item':'cabbage'},
        {'item':'lettuce'},
        {'item':'corn'},
      ],
      'category': 'Vegetable',
    },
];

String getCategoryFromItem(String itemName, List<Map<dynamic, dynamic>> categories) {
  // Iterate through each category
  for (var category in categories) {
    // Check if the item exists in the category's 'items' list
    final items = category['items'] as List<Map<dynamic, dynamic>>;
    if (items.any((element) => element['item'] == itemName)) {
      return category['category'] as String; // Return the category name
    }
  }
  return 'Others'; // Return 'Others' if the item is not found in any category
}

class GroceryList extends StatelessWidget {
  final String category;
  final List<GroceryItem> grocerylist;

  const GroceryList({
    Key? key,
    required this.category,
    required this.grocerylist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryIcon = {
      'Vegetable': Icons.local_florist,
      'Meat': Icons.fastfood,
      'Others': Icons.library_books
    };

    final categoryColor = {
      'Vegetable': Colors.green,
      'Meat': Colors.brown,
      'Others': Colors.grey,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          color: categoryColor[category] ?? Colors.grey[200],
          child: Row(
            children: [
              Icon(
                categoryIcon[category] ?? Icons.help,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                category,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        ...grocerylist,
      ],
    );
  }
}

class GroceryItem extends StatelessWidget {
  final String item;
  final String quantity;

  GroceryItem({
    Key? key,
    required this.item,
    this.quantity = '',
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    String category = getCategoryFromItem(item, groceryCategories);

    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              quantity.isEmpty ? item : "$item ($quantity)",
              style: const TextStyle(fontSize: 16),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, size: 18),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: BlocProvider.of<GroceryBloc>(context),
                    child: EditGroceryScreen(
                      item: item,
                      quantity: quantity,
                      category: category,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}