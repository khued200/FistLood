import 'package:flutter/material.dart';
import 'package:shopping_conv/checkpoint/grocery_list_screen.dart';
import 'package:shopping_conv/ui/home_screen.dart';
import 'package:shopping_conv/ui/list/grocery_list_screen.dart';
import 'package:shopping_conv/ui/meal_plan/meal_plan_screen.dart';
import 'package:shopping_conv/ui/meal_plan/recipe_search_screen.dart';
import 'package:shopping_conv/ui/profile/profile_view_screen.dart';
import 'package:shopping_conv/ui/register/register_screen.dart';

class AppRoutes {
  static const String groceryList = '/groceryList';
  static const String mealPlanner = '/mealPlanner';
  static const String recipeSearch = '/recipeSearch';
  static const String settings = '/settings';
  static const String register = '/register';
  static const String homescreen = '/homescreen';
  static const String profileView = '/profileView';


  static Map<String, WidgetBuilder> getRoutes() {
    return {
      homescreen: (context) => HomeScreen(),
      // mealPlanner: (context) => MealPlanScreen(),
      // recipeSearch: (context) => RecipeSearchScreen(),
      // settings: (context) => Center(child: Text("Settings Screen")),
      register: (context) => RegisterScreen(),
      profileView: (context) => ProfileScreen(),
    };
  }
}
