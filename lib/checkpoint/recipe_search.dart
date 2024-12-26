// import 'package:flutter/material.dart';
// import 'package:shopping_conv/blocs/navigation/navigation.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:shopping_conv/ui/app_routes.dart';
// import 'package:shopping_conv/ui/helper_func.dart';
// import '../utils.dart';

// class RecipeSearchScreen extends StatefulWidget {
//   @override
//   _RecipeSearchScreenState createState() => _RecipeSearchScreenState();
// }

// class _RecipeSearchScreenState extends State<RecipeSearchScreen> {
//   @override
//   final TextEditingController recipeController = TextEditingController();
//   final FocusNode recipeFocusNode = FocusNode();

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: constant Color.fromRGBO(158, 237, 255, 100),
//         title: TextField(
//           decoration: InputDecoration(
//             hintText: 'Search recipes',
//             border: InputBorder.none,
//           ),
//           controller: recipeController,
//           focusNode: recipeFocusNode,
//         ),
//         leading: IconButton(
//           icon: constant Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context); // Navigate back
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.close, color: Colors.black),
//             onPressed: () {
//               // More options action
//             },
//           ),
//         ],
//       ),
//       body:Stack(
//         children: [
//           Container(
//             decoration: constant BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/background.png'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           ListView(
//           children: [
//             _buildSectionHeader("New recipes"),
//             _buildListTile(
//               context,
//               title: "Create New Recipes",
//               icon: Icons.restaurant_menu,
//               onTap: () {
//                 // Navigate to create new recipes
//               },
//             ),
//             // constant Divider(height: 1, thickness: 1, c olor: Colors.grey),
//             _buildSectionHeader("Existing recipes"),
//             _buildListTile(
//               context,
//               title: "All Recipes",
//               icon: Icons.restaurant_menu,
//               onTap: () {
//                 // Navigate to all recipes
//               },
//             ),
//             _buildListTile(
//               context,
//               title: "Main Dishes",
//               icon: Icons.restaurant_menu,
//               onTap: () {
//                 // Navigate to main dishes
//               },
//             ),
//             _buildListTile(
//               context,
//               title: "Side Dishes",
//               icon: Icons.restaurant_menu,
//               onTap: () {
//                 // Navigate to side dishes
//               },
//             ),
//             constant Divider(height: 1, thickness: 1, color: Colors.grey),
//           ],
//         ),
//         ],
//       ) ,
//     // bottomNavigationBar: CustomBottomNavigation()
//     );
//   }

//     Widget _buildSectionHeader(String title) {
//       return Container(
//         padding: constant EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         color: constant Color.fromRGBO(229, 223, 223, 1), // Light gray for section header background
//         child: Row(
//           children: [
//             constant Icon(Icons.restaurant_menu, size: 18),
//             constant SizedBox(width: 8),
//             Text(
//               title,
//               style: constant TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     Widget _buildListTile(
//       BuildContext context, {
//       required String title,
//       required IconData icon,
//       required VoidCallback onTap,
//     }) {
//       return Container(
//         decoration: BoxDecoration(
//           color: Color.fromRGBO(255, 255, 255, 1),
//           border: Border.symmetric(horizontal: BorderSide(color: Colors.grey))
//         ),
//         child: ListTile(
//           contentPadding: constant EdgeInsets.symmetric(horizontal: 16),
//           title: Text(
//             title,
//             style: constant TextStyle(fontSize: 16),
//           ),
//           trailing: constant Icon(Icons.arrow_forward_ios, size: 16),
//           onTap: onTap,
//         ),
//       ); 
//   }
// }