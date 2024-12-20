import 'package:flutter/material.dart';
import 'app_routes.dart'; // Ensure you import the AppRoutes file

// int getCurrentIndex(BuildContext context) {
//   final routeName = ModalRoute.of(context)?.settings.name;
//   if (routeName == AppRoutes.groceryList) {
//     return 0;
//   } else if (routeName == AppRoutes.mealPlanner) {
//     return 2;
//   }
//   // } else if (routeName == AppRoutes.settings) {
//   //   return 3;
//   // }
//   return 0; // Default to "Lists"
// }

String getRouteFromIndex(int index) {
  switch (index) {
    case 0:
      return AppRoutes.groceryList;
    case 2:
      return AppRoutes.mealPlanner;
    default:
      return AppRoutes.groceryList;
  }
}

Color getMealTypeColor(String mealType) {
  switch (mealType) {
    case 'Breakfast':
      return const Color(0xFF0066FF); // Blue
    case 'Lunch':
      return const Color(0xFFFF8000); // Orange
    case 'Dinner':
      return const Color(0xFFFF0000); // Red
    default:
      return const Color(0xFF808080); // Gray for undefined meal types
  }
}
