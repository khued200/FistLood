import 'package:flutter/material.dart';
import 'package:shopping_conv/ui/list/grocery_list_screen.dart';
import 'package:shopping_conv/ui/meal_plan/meal_planner.dart';

class AppRoutes {
  static const String groceryList = '/';
  static const String mealPlanner = '/mealPlanner';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      groceryList: (context) => GroceryListScreen(),
      mealPlanner: (context) => MealPlanScreen(),
    };
  }
}
