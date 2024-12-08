import 'package:flutter/material.dart';
import 'app_routes.dart'; // Ensure you import the AppRoutes file

int getCurrentIndex(BuildContext context) {
  final routeName = ModalRoute.of(context)?.settings.name;
  if (routeName == AppRoutes.groceryList) {
    return 0;
  } else if (routeName == AppRoutes.mealPlanner) {
    return 2;
  }
  // } else if (routeName == AppRoutes.settings) {
  //   return 3;
  // }
  return 0; // Default to "Lists"
}
