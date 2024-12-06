import 'package:flutter/material.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({Key? key}) : super(key: key);

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  bool isAddingItem = false;
  final TextEditingController itemController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final List<Map<dynamic, dynamic>> groceryCategories = [
    {
      'items': [
        {'item':'Chicken'},
        {'item':'Pork'},
        {'item':'Beef'},
        {'item':'Lamp'},
      ],
      'category': 'Meat',
    },
    {
      'items': [
        {'item':'Cabbage'},
        {'item':'Lettuce'},
        {'item':'Corn'},
      ],
      'category': 'Vegetable',
    },
    {
      'items':[],
      "category":"Others",
    }
    // {
    //   'category': 'Meat',
    //   'items': [
    //     {'item': 'Chicken'},
    //   ],
    // },
  ];

  List<GroceryList> groceryList = [];

  String selectedCategory = 'Others';

  void appendItem(String itemName, String quantity) {
    if (itemName.isNotEmpty) {
      setState(() {
        // Find the category of the item from the groceryCategories list
        var category = groceryCategories.firstWhere(
          (cat) {
            // Check if the item exists in this category
            return cat['items'].any((item) => item['item'] == itemName);
          },
          orElse: () {
            // If no category found, return a default category ('Others')
            return {'category': 'Others', 'items': []};
          },
        );

        // Now, find the corresponding GroceryList category in the groceryList
        var groceryListCategory = groceryList.firstWhere(
          (list) => list.category == category['category'],
          orElse: () {
            // If no such category exists, create a new one
            GroceryList newGroceryList = GroceryList(
              category: category['category'], // Use the category found above
              grocerylist: [],
            );
            groceryList.add(newGroceryList); // Add the new category to groceryList
            return newGroceryList; // Return the new category
          },
        );

        // Add the new item to the category's grocery list
        groceryListCategory.grocerylist.add(GroceryItem(
          item: itemName,   // Item name input
          quantity: quantity, // Quantity input
        ));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(158, 237, 255, 100),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('My Grocery List', style: TextStyle(fontSize: 20)),
            Text('3 Items', style: TextStyle(fontSize: 12)),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pop(context); // Navigate back
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Additional actions
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background
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
              if (!isAddingItem)
                Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(95, 237, 166, 1),
                      border: Border(
                        top: BorderSide(color: Colors.black),
                      ),
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
                            setState(() {
                              isAddingItem = true;
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.add),
                              SizedBox(width: 5),
                              Text(
                                'Add Item',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              if (isAddingItem)
                Container(
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
                              setState(() {
                                isAddingItem = false;
                              });
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              if (itemController.text.isNotEmpty) {
                                // Add the item to the list
                                setState(() {
                                  // Add item logic here
                                  appendItem(itemController.text, quantityController.text);
                                  isAddingItem = false;
                                  itemController.clear();
                                  quantityController.clear();
                                });
                              }
                            },
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              
                Expanded(
                  child: ListView.builder(
                      itemCount: groceryList.length, // The total number of categories
                      itemBuilder: (context, index) {
                        final category = groceryList[index];

                        // Skip rendering if category has no items
                        if (category.grocerylist.isEmpty) {
                          return Container(); // Return an empty container if there are no items
                        }

                        return GroceryList(
                          category: category.category, // Pass category name
                          grocerylist: category.grocerylist, // Pass list of grocery items
                        );
                      },
                  ),
                ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Lists"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Recipes"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Meal Plan"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
        selectedItemColor: const Color.fromRGBO(255, 102, 102, 30),
        unselectedItemColor: const Color.fromRGBO(117, 117, 117, 100),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
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
    };

    final categoryColor = {
      'Vegetable': Colors.green,
      'Meat': Colors.brown,
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

  const GroceryItem({
    Key? key,
    required this.item,
    this.quantity = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              "$item $quantity",
              style: const TextStyle(fontSize: 16),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, size: 18),
            onPressed: () {
              // Edit functionality
            },
          ),
        ],
      ),
    );
  }
}
