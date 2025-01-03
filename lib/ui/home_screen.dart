import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/blocs/navigation/navigation.dart';
import 'package:shopping_conv/ui/fridge/fridge_screen.dart';
import 'package:shopping_conv/ui/profile/profile_view_screen.dart';
import 'package:shopping_conv/ui/profile/user_profile_view_model.dart';
import 'package:shopping_conv/ui/register/login_view_model.dart';
import 'package:shopping_conv/ui/register/register_screen.dart';
import 'list/grocery_list_screen.dart';
import '../ui/meal_plan/meal_plan_screen.dart';
import '../ui/meal_plan/recipe_search_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  final List<Widget> _initialScreens = [
    GroceryListScreen(),
    FridgeScreen(),
    MealPlanScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: List.generate(
              _initialScreens.length,
              (index) => _buildOffstageNavigator(index, state.currentIndex),
            ),
          ),
          bottomNavigationBar: CustomBottomNavigation(),
        );
      },
    );
  }

  Widget _buildOffstageNavigator(int index, int currentIndex) {
    return Offstage(
      offstage: currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (_) => _initialScreens[index],
          );
        },
      ),
    );
  }
}

class CustomBottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            if (state.currentIndex != index) {
              if (index == 3){
                context.read<ProfileViewModel>().fetchProfile(context);
              }
              context.read<NavigationBloc>().add(NavigateToTab(index));
            } else {
              // Pop to first screen in the current tab
              _resetCurrentTab(index, context);
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Lists"),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "Recipes"),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), label: "Meal Plan"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ],
        );
      },
    );
  }

  void _resetCurrentTab(int index, BuildContext context) {
    final navigatorKey = context.read<HomeScreen>()._navigatorKeys[index];
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }
}

