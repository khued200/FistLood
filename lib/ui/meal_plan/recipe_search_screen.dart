import 'package:shopping_conv/blocs/mealplan/meal_plan_bloc.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_state.dart';
import 'package:shopping_conv/blocs/navigation/navigation.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/ui/helper_func.dart';
import 'package:shopping_conv/blocs/mealplan/recipe_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class RecipeSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeSearchBloc(),
      child: _RecipeSearchView(),
    );
  }
}

class _RecipeSearchView extends StatefulWidget {
  @override
  _RecipeSearchViewState createState() => _RecipeSearchViewState();
}

class _RecipeSearchViewState extends State<_RecipeSearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(158, 237, 255, 100),
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search recipes',
            border: InputBorder.none,
          ),
          onChanged: (query) {
            context.read<RecipeSearchBloc>().add(SearchRecipes(query));
          },
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<RecipeSearchBloc, RecipeSearchState>(
        builder: (context, state) {
          if (state is RecipeSearchLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is RecipeSearchError) {
            return Center(child: Text(state.message));
          }

          if (state is RecipeSearchLoaded) {
            return _buildRecipeList(context, state);
          }

          return _buildInitialView(context);
        },
      ),
    );
  }

  Widget _buildRecipeList(BuildContext context, RecipeSearchState state) {
    return Container(child: Text('RecipeList'));
  }

  Widget _buildInitialView(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        ListView(
          children: [
            _buildSectionHeader("New recipes"),
            _buildListTile(
              context,
              title: "Create New Recipes",
              icon: Icons.restaurant_menu,
              onTap: () {
                // Navigate to create new recipes
              },
            ),
            // const Divider(height: 1, thickness: 1, c olor: Colors.grey),
            _buildSectionHeader("Existing recipes"),
            _buildListTile(
              context,
              title: "All Recipes",
              icon: Icons.restaurant_menu,
              onTap: () {
                // Navigate to all recipes
              },
            ),
            _buildListTile(
              context,
              title: "Main Dishes",
              icon: Icons.restaurant_menu,
              onTap: () {
                // Navigate to main dishes
              },
            ),
            _buildListTile(
              context,
              title: "Side Dishes",
              icon: Icons.restaurant_menu,
              onTap: () {
                // Navigate to side dishes
              },
            ),
            const Divider(height: 1, thickness: 1, color: Colors.grey),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color.fromRGBO(
          229, 223, 223, 1), // Light gray for section header background
      child: Row(
        children: [
          const Icon(Icons.restaurant_menu, size: 18),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          border: Border.symmetric(horizontal: BorderSide(color: Colors.grey))),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
    // Implement _buildRecipeList and _buildInitialView methods...
  }
}
