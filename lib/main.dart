// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shopping_conv/ui/meal_plan/meal_planner.dart';
import 'package:shopping_conv/ui/list/grocery_list_screen.dart';
import 'package:shopping_conv/ui/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.groceryList, // Use named route from AppRoutes
      routes: AppRoutes.getRoutes(), // Import the centralized routes
      debugShowCheckedModeBanner: true,
      // home: GroceryListScreen(),
      title: 'GroceryListScreen',
      theme: ThemeData(primarySwatch: Colors.cyan),
    );
  }
}

