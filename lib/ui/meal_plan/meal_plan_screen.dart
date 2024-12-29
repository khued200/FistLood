import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shopping_conv/ui/meal_plan/widgets/meal_plan_models.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_event.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_state.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_bloc.dart';
import 'package:shopping_conv/blocs/navigation/navigation.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/ui/helper_func.dart';
import 'package:shopping_conv/ui/meal_plan/recipe_search_screen.dart';

class MealPlanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<MealPlanBloc>()
        ..add(LoadMealsForDay(
            DateTime.now())), // Share the same MealPlanBloc instance
      child: _MealPlanView(),
    );
  }
}

class _MealPlanView extends StatefulWidget {
  @override
  _MealPlanViewState createState() => _MealPlanViewState();
}

class _MealPlanViewState extends State<_MealPlanView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    _loadMealsForSelectedDay();
  }

  void _loadMealsForSelectedDay() {
    if (!mounted) return;
    context.read<MealPlanBloc>().add(LoadMealsForDay(_selectedDay));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealPlanBloc, MealPlanState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0x9C9EEDFF),
            elevation: 0,
            title: Text('Meal Plan',
                style: TextStyle(color: Colors.black, fontSize: 20)),
          ),
          body: Column(
            children: [
              _buildCalendar(context, state),
              _buildActionButtons(context),
              Expanded(
                child: _buildMealsList(
                    state.meals[_normalizeDate(_selectedDay)] ?? [],
                    _selectedDay
                  ),
              ),
              if (state.error.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error: ${state.error}',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Color(0x9CE5DFDF),
                border: Border(
                  top: BorderSide(color: Color(0x9C837575), width: 2),
                  left: BorderSide(color: Color(0x9C837575), width: 2),
                  right: BorderSide(color: Color(0x9C837575), width: 1),
                  bottom: BorderSide(color: Color(0x9C837575), width: 2),
                )),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: context.read<
                          MealPlanBloc>(), // Pass the existing MealPlanBloc
                      child: RecipeSearchScreen(selectedDay: _selectedDay),
                    ),
                  ),
                );
              },
              child: Text('Add meal', style: TextStyle(color: Colors.black)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendar(BuildContext context, MealPlanState state) {
    return Container(
      decoration: const BoxDecoration(color: Color(0x9CC3FCDF)),
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        eventLoader: (day) {
          final normalizedDay = _normalizeDate(day);
          return state.meals[normalizedDay] ?? [];
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          _loadMealsForSelectedDay();
        },
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            if (events.isEmpty) return null;
            final dishesPlannedList = events.cast<DishesPlanned>();
            // Create colored dots for each event
            return Positioned(
              bottom: 1,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: dishesPlannedList.map((event) {
                  final color = getMealTypeColor(event.mealType);
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1.0),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  Widget _buildMealsList(List<DishesPlanned> meals, DateTime day) {
    if (meals.isEmpty) {
      return Center(
        child: Text('No meals planned for this day'),
      );
    }

    return ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(
              meal.mealName,
              // style: TextStyle(color: getMealTypeColor(meal.mealType)), // Change text color
            ),
            subtitle: Text(
              meal.mealType,
              // style: TextStyle(color: getMealTypeColor(meal.mealType)), // Change subtitle color
            ),
            leading: Icon(
              _getMealTypeIcon(meal.mealType),
              color: getMealTypeColor(meal.mealType), // Change icon color
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _showDeleteDialog(meal,day);
              },
            ),
          ),
        );
      },
    );
  }

  void _showDeleteDialog(DishesPlanned meal, DateTime day) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Meal'),
          content: Text('Are you sure you want to delete the meal: ${meal.mealName}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<MealPlanBloc>().add(DeleteMeal(meal,day)); // Replace with your delete event
                Navigator.of(context).pop();
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  IconData _getMealTypeIcon(String mealType) {
    switch (mealType) {
      case 'Breakfast':
        return Icons.breakfast_dining;
      case 'Lunch':
        return Icons.lunch_dining;
      case 'Dinner':
        return Icons.dinner_dining;
      default:
        return Icons.restaurant;
    }
  }
}
