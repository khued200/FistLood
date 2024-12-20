import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_bloc.dart';
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/blocs/navigation/navigation.dart';
import '../ui/home_screen.dart';
import '../blocs/grocery/grocery_list_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(create: (context) => GroceryBloc()),
        BlocProvider(create: (context) => MealPlanBloc()),
        // Add other BLoCs here
      ],
      child: MaterialApp(
        home: HomeScreen(),
        onGenerateRoute: (settings) {
          // Handle other routes that aren't part of bottom navigation
          return MaterialPageRoute(
            builder: (context) => HomeScreen(),
          );
        },
      ),
    );
  }
}
