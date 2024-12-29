import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/ui/helper_func.dart';
import 'package:shopping_conv/ui/list/widgets/grocery_item_list.dart';
import 'package:shopping_conv/blocs/grocery/grocery_list_bloc.dart';
import 'package:shopping_conv/blocs/grocery/grocery_list_state.dart';
import 'package:shopping_conv/blocs/grocery/grocery_list_event.dart';
import 'package:shopping_conv/ui/list/widgets/grocery_item_list.dart';
import 'package:shopping_conv/blocs/navigation/navigation.dart';


class GroceryListScreen extends StatelessWidget {
  final TextEditingController itemController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroceryBloc, GroceryState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(158, 237, 255, 100),
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back),
            //   onPressed: () {
            //     // Navigator.pop(context);
            //   },
            // ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('My Grocery List', style: TextStyle(fontSize: 20)),
                Text(
                  _getTotalItemsText(state.groceryLists),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  _buildAddItemSection(context, state),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.groceryLists.length,
                      itemBuilder: (context, index) {
                        final category = state.groceryLists[index];
                        if (category.grocerylist.isEmpty) {
                          return Container();
                        }
                        return GroceryList(
                          category: category.category,
                          grocerylist: category.grocerylist,
                        );
                      },
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add share functionality
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.family_restroom),
                          SizedBox(width: 8),
                          Text('Share with family member'),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddItemSection(BuildContext context, GroceryState state) {
    if (!state.isAddingItem) {
      return Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(95, 237, 166, 1),
          // border: Border(top: BorderSide(color: Colors.black)),
        ),
        height: 50,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFFA1AEAF)),
            ),
            child: GestureDetector(
              onTap: () {
                context.read<GroceryBloc>().add(ToggleAddItemMode(true));
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.add),
                  SizedBox(width: 5),
                  Text('Add Item', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(10),
      color: Color.fromRGBO(95, 237, 166, 1),
      child: Column(
        children: [
          TextField(
            controller: itemController,
            decoration: const InputDecoration(
              hintText: 'Item Name',
              border: OutlineInputBorder(),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: quantityController,
            decoration: const InputDecoration(
              hintText: 'Quantity',
              border: OutlineInputBorder(),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  context.read<GroceryBloc>().add(ToggleAddItemMode(false));
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (itemController.text.isNotEmpty) {
                    context.read<GroceryBloc>().add(AddGroceryItem(
                      item: itemController.text,
                      quantity: quantityController.text,
                      category: getCategoryFromItem(itemController.text.toLowerCase(),groceryCategories), // Default category
                    ));
                    itemController.clear();
                    quantityController.clear();
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
          
        ],
      ),
    );
  }

  String _getTotalItemsText(List<GroceryList> lists) {
    final total = lists.fold(0, (sum, category) => sum + category.grocerylist.length);
    if (total == 0) return "No items";
    if (total == 1) return "1 item";
    return "$total items";
  }
}

