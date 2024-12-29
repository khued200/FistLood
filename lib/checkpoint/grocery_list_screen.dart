// import 'package:flutter/material.dart';
// import 'package:shopping_conv/ui/app_routes.dart';
// import 'package:shopping_conv/ui/helper_func.dart';

// class GroceryListScreen extends StatefulWidget {
//   constant GroceryListScreen({Key? key}) : super(key: key);

//   @override
//   State<GroceryListScreen> createState() => _GroceryListScreenState();
// }

// class _GroceryListScreenState extends State<GroceryListScreen> {
//   bool isAddingItem = false;
//   final TextEditingController itemController = TextEditingController();
//   final TextEditingController quantityController = TextEditingController();
//   final FocusNode itemFocusNode = FocusNode();
//   final FocusNode quantityFocusNode = FocusNode();

// // Dispose of the focus nodes to avoid memory leaks
//   @override
//   void dispose() {
//     itemFocusNode.dispose();
//     quantityFocusNode.dispose();
//     itemController.dispose();
//     quantityController.dispose();
//     super.dispose();
//   }

//   final List<Map<dynamic, dynamic>> groceryCategories = [
//     {
//       'items': [
//         {'item':'Chicken'},
//         {'item':'Pork'},
//         {'item':'Beef'},
//         {'item':'Lamp'},
//       ],
//       'category': 'Meat',
//     },
//     {
//       'items': [
//         {'item':'Cabbage'},
//         {'item':'Lettuce'},
//         {'item':'Corn'},
//       ],
//       'category': 'Vegetable',
//     },
//     {
//       'items':[],
//       "category":"Others",
//     }
//     // {
//     //   'category': 'Meat',
//     //   'items': [
//     //     {'item': 'Chicken'},
//     //   ],
//     // },
//   ];

//   List<GroceryList> groceryList = [];

//   String selectedCategory = 'Others';

//   void appendItem(String itemName, String quantity) {
//     if (itemName.isNotEmpty) {
//       setState(() {
//         // Find the category of the item from the groceryCategories list
//         var category = groceryCategories.firstWhere(
//           (cat) {
//             // Check if the item exists in this category
//             return cat['items'].any((item) => item['item'] == itemName);
//           },
//           orElse: () {
//             // If no category found, return a default category ('Others')
//             return {'category': 'Others', 'items': []};
//           },
//         );

//         // Now, find the corresponding GroceryList category in the groceryList
//         var groceryListCategory = groceryList.firstWhere(
//           (list) => list.category == category['category'],
//           orElse: () {
//             // If no such category exists, create a new one
//             GroceryList newGroceryList = GroceryList(
//               category: category['category'], // Use the category found above
//               grocerylist: [],
//             );
//             groceryList.add(newGroceryList); // Add the new category to groceryList
//             return newGroceryList; // Return the new category
//           },
//         );

//         // Add the new item to the category's grocery list
//         groceryListCategory.grocerylist.add(GroceryItem(
//           item: itemName,   // Item name input
//           quantity: quantity, // Quantity input
//         ));
//       });
//     }
//   }

//   int getTotalItems() {
//     return groceryList.fold(0, (total, category) => total + category.grocerylist.length);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: constant Color.fromRGBO(158, 237, 255, 100),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             constant Text('My Grocery List', style: TextStyle(fontSize: 20)),
//             Text(
//               getTotalItems() == 0
//                   ? "No items"
//                   : getTotalItems() == 1
//                       ? "1 item"
//                       : "${getTotalItems()} items",
//               style: constant TextStyle(fontSize: 12),
//             ),
//           ],
//         ),
//         leading: IconButton(
//           icon: constant Icon(Icons.arrow_back),
//           onPressed: () {
//             // Navigator.pop(context); // Navigate back
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: constant Icon(Icons.more_vert),
//             onPressed: () {
//               // Additional actions
//             },
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           // Background
//           Container(
//             decoration: constant BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/background.png'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Column(
//             children: [
//               if (!isAddingItem)
//                 Container(
//                     decoration: constant BoxDecoration(
//                       color: Color.fromRGBO(95, 237, 166, 1),
//                       border: Border(
//                         top: BorderSide(color: Colors.black),
//                       ),
//                     ),
//                     height: 50,
//                     child: Center(
//                       child: Container(
//                         padding: constant EdgeInsets.all(5),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: Color(0xFFA1AEAF)),
//                         ),
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               isAddingItem = true;
//                             });
//                           },
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: constant [
//                               Icon(Icons.add),
//                               SizedBox(width: 5),
//                               Text(
//                                 'Add Item',
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//               if (isAddingItem)
//                 Container(
//                   padding: constant EdgeInsets.all(10),
//                   color: Color.fromRGBO(95, 237, 166, 1),
//                   child: Column(
//                     children: [
                
//                       TextField(
//                         controller: itemController,
//                         focusNode: itemFocusNode,
//                         decoration: constant InputDecoration(
//                           hintText: 'Item Name',
//                           border: OutlineInputBorder(),
//                           fillColor: Colors.white,
//                           filled: true,
//                         ),
//                       ),

                      
//                       constant SizedBox(height: 10),

//                       TextField(
//                         controller: quantityController,
//                         focusNode: quantityFocusNode,
//                         decoration: constant InputDecoration(
//                           hintText: 'Quantity',
//                           border: OutlineInputBorder(),
//                           fillColor: Colors.white,
//                           filled: true,
//                         ),
//                       ),

//                       constant SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           TextButton(
//                             onPressed: () {
//                               setState(() {
//                                 isAddingItem = false;
//                               });
//                             },
//                             child: constant Text('Cancel'),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               if (itemController.text.isNotEmpty) {
//                                 // Add the item to the list
//                                 setState(() {
//                                   // Add item logic here
//                                   appendItem(itemController.text, quantityController.text);
//                                   isAddingItem = false;
//                                   itemController.clear();
//                                   quantityController.clear();
//                                 });
//                               }
//                             },
//                             child: constant Text('Add'),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
              
//                 Expanded(
//                   child: ListView.builder(
//                       itemCount: groceryList.length, // The total number of categories
//                       itemBuilder: (context, index) {
//                         final category = groceryList[index];

//                         // Skip rendering if category has no items
//                         if (category.grocerylist.isEmpty) {
//                           return Container(); // Return an empty container if there are no items
//                         }

//                         return GroceryList(
//                           category: category.category, // Pass category name
//                           grocerylist: category.grocerylist, // Pass list of grocery items
//                         );
//                       },
//                   ),
//                 ),
//             ],
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: getCurrentIndex(context),
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.red,
//         unselectedItemColor: Colors.grey,
//         onTap: (index) {
//           switch (index) {
//             case 0:
//               // Navigator.pushNamedAndRemoveUntil(context, AppRoutes.groceryList, (route) => false);
//               break;
//             case 1:
//               // Navigator.pushNamedAndRemoveUntil(context, AppRoutes.foodRecipes, (route) => false);
//               break;
//             case 2:
//               Navigator.pushNamed(context, AppRoutes.mealPlanner);
//               break;
//             case 3:
//               // Navigator.pushNamedAndRemoveUntil(context, AppRoutes.settings, (route) => false);
//               break;
//           }
//         },

//         items: constant [
//           BottomNavigationBarItem(icon: Icon(Icons.list), label: "Lists"),
//           BottomNavigationBarItem(icon: Icon(Icons.book), label: "Recipes"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.calendar_today), label: "Meal Plan"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.settings), label: "Settings"),
//         ],
//       ),
//     );
//   }
// }

// class GroceryList extends StatelessWidget {
//   final String category;
//   final List<GroceryItem> grocerylist;

//   constant GroceryList({
//     Key? key,
//     required this.category,
//     required this.grocerylist,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final categoryIcon = {
//       'Vegetable': Icons.local_florist,
//       'Meat': Icons.fastfood,
//     };

//     final categoryColor = {
//       'Vegetable': Colors.green,
//       'Meat': Colors.brown,
//     };

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: constant EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//           color: categoryColor[category] ?? Colors.grey[200],
//           child: Row(
//             children: [
//               Icon(
//                 categoryIcon[category] ?? Icons.help,
//                 color: Colors.white,
//               ),
//               constant SizedBox(width: 8),
//               Text(
//                 category,
//                 style: constant TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         ...grocerylist,
//       ],
//     );
//   }
// }

// class GroceryItem extends StatelessWidget {
//   final String item;
//   final String quantity;

//   constant GroceryItem({
//     Key? key,
//     required this.item,
//     this.quantity = '',
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       padding: constant EdgeInsets.only(left: 10),
//       decoration: constant BoxDecoration(
//         color: Colors.white,
//         border: Border(
//           bottom: BorderSide(color: Colors.grey),
//         ),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               quantity.isEmpty ? item : "$item ($quantity)",
//               style: constant TextStyle(fontSize: 16),
//             ),
//           ),
//           IconButton(
//             icon: constant Icon(Icons.edit, size: 18),
//             onPressed: () {
//               // Edit functionality
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
