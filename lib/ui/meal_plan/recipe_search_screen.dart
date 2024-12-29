import 'package:shopping_conv/blocs/mealplan/meal_plan_bloc.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_event.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_state.dart';
import 'package:shopping_conv/blocs/navigation/navigation.dart';
import 'package:shopping_conv/ui/meal_plan/widgets/meal_plan_models.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/ui/helper_func.dart';
import 'package:shopping_conv/blocs/mealplan/recipe_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// class RecipeSearchScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => RecipeSearchBloc(),
//       child: _RecipeSearchView(),
//     );
//   }
// }

// class _RecipeSearchView extends StatefulWidget {
//   @override
//   _RecipeSearchViewState createState() => _RecipeSearchViewState();
// }

// class _RecipeSearchViewState extends State<_RecipeSearchView> {
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromRGBO(158, 237, 255, 100),
//         title: TextField(
//           controller: _searchController,
//           decoration: InputDecoration(
//             hintText: 'Search recipes',
//             border: InputBorder.none,
//           ),
//           onChanged: (query) {
//             context.read<RecipeSearchBloc>().add(SearchRecipes(query));
//           },
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: BlocBuilder<RecipeSearchBloc, RecipeSearchState>(
//         builder: (context, state) {
//           if (state is RecipeSearchLoading) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (state is RecipeSearchError) {
//             return Center(child: Text(state.message));
//           }

//           if (state is RecipeSearchLoaded) {
//             return _buildRecipeList(context, state);
//           }

//           return _buildInitialView(context);
//         },
//       ),
//     );
//   }

//   Widget _buildRecipeList(BuildContext context, RecipeSearchState state) {
//     return Container(child: Text('RecipeList'));
//   }

//   Widget _buildInitialView(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/background.png'),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         ListView(
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
//             // const Divider(height: 1, thickness: 1, c olor: Colors.grey),
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
//             const Divider(height: 1, thickness: 1, color: Colors.grey),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildSectionHeader(String title) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       color: const Color.fromRGBO(
//           229, 223, 223, 1), // Light gray for section header background
//       child: Row(
//         children: [
//           const Icon(Icons.restaurant_menu, size: 18),
//           const SizedBox(width: 8),
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildListTile(
//     BuildContext context, {
//     required String title,
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Color.fromRGBO(255, 255, 255, 1),
//         border: Border.symmetric(horizontal: BorderSide(color: Colors.grey)),
//       ),
//       child: ListTile(
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//         title: Text(
//           title,
//           style: const TextStyle(fontSize: 16),
//         ),
//         trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//         onTap: () {
//           // Create a recipe and add it to the meal plan
//           final recipe = Recipe(
//             name: title,
//             type: 'Main Dish', // You can modify this based on the section
//           );
          
//           // Get the MealPlanBloc from the parent context
//           final mealPlanBloc = context.read<MealPlanBloc>();
          
//           // Add the meal to the plan for the selected day
//           mealPlanBloc.add(AddMealToPlan(recipe, DateTime.now())); // You'll need to pass the selected date
          
//           // Navigate back to the calendar
//           Navigator.pop(context);
//         },
//       ),
//     );
//     // Implement _buildRecipeList and _buildInitialView methods...
//   }
// }

class RecipeSearchScreen extends StatelessWidget {
  final DateTime selectedDay;

  const RecipeSearchScreen({
    Key? key,
    required this.selectedDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<MealPlanBloc>(), // Share the same MealPlanBloc instance
      child: _RecipeSearchView(selectedDay: selectedDay),
    );
  }
}

class _RecipeSearchView extends StatefulWidget {
  final DateTime selectedDay;

  const _RecipeSearchView({
    Key? key,
    required this.selectedDay,
  }) : super(key: key);

  @override
  _RecipeSearchViewState createState() => _RecipeSearchViewState();
}

class _RecipeSearchViewState extends State<_RecipeSearchView> {
  final TextEditingController _recipeNameController = TextEditingController();
  MealType _selectedType = MealType.Breakfast;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(158, 237, 255, 100),
        title: Text('Thêm món ăn'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<MealPlanBloc, MealPlanState>(
        listener: (context, state) {
          if (state.error.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error))
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _recipeNameController,
                decoration: InputDecoration(
                  labelText: 'Tên món ăn',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Meal Type',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ...MealType.values.map((type) => RadioListTile<MealType>(
                title: Text(type.name),
                value: type,
                groupValue: _selectedType,
                onChanged: (MealType? value) {
                  if (value != null) {
                    setState(() {
                      _selectedType = value;
                    });
                  }
                },
              )).toList(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addMealToPlan,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                  'Thêm vào kế hoạch',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addMealToPlan() {
    if (_recipeNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nhập tên món ăn')),
      );
      return;
    }

    final recipe = Recipe(
      name: _recipeNameController.text.trim(),
      type: _selectedType.name,
    );

    // Gửi sự kiện để thêm bữa ăn vào kế hoạch, sử dụng selectedDay từ widget
    context.read<MealPlanBloc>().add(AddMealToPlan(recipe, widget.selectedDay));

    // Hiển thị thông báo thành công
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Thêm món ăn vào kế hoạch')),
    );

    // Quay lại màn hình lịch
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _recipeNameController.dispose();
    super.dispose();
  }
}