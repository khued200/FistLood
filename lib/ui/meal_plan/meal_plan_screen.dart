import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_bloc.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_event.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_state.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shopping_conv/ui/constant/error.dart';

class MealScreen extends StatelessWidget {
  void _showAddMealDialog(BuildContext context) {
    final _nameController = TextEditingController();
    final _descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Add New Meal'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Meal Name'),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final name = _nameController.text.trim();
                  final description = _descriptionController.text.trim();

                  if (name.isNotEmpty && description.isNotEmpty) {
                    // context.read<MealPlanBloc>().add(
                    //   // AddMealPlan(name: name, description: description),
                    // );
                    Navigator.pop(dialogContext);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields')),
                    );
                  }
                },
                child: Text('Add'),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Plan'),
        backgroundColor: Colors.green,
      ),
      body: BlocListener<MealPlanBloc, MealPlanState>(
        listener: (context, state) {
          if (state is MealPlanAdded) {
            // Refresh the meal list after adding a new meal
            context.read<MealPlanBloc>().add(
              LoadMealsForDay(
                context,
                DateTime.now().millisecondsSinceEpoch,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Meal added successfully')),
            );
          } else if (state is MealPlanError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to add meal: ${state.message}')),
            );
          }
        },
        child: BlocBuilder<MealPlanBloc, MealPlanState>(
          builder: (context, state) {
            if (state is MealPlanLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MealPlanLoaded) {
              return Column(
                children: [
                  _buildCalendar(context, state),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<MealPlanBloc>().add(
                          LoadMealsForDay(
                            context,
                            state.selectedDay,
                          ),
                        );
                      },
                      child: state.meals.isNotEmpty
                          ? ListView.builder(
                        itemCount: state.meals.length,
                        itemBuilder: (context, index) {
                          final meal = state.meals[index];

                          return GestureDetector(
                            onTap: () {
                              // Navigate to meal detail screen (to be implemented)
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                child: Icon(Icons.fastfood, color: Colors.green),
                              ),
                              title: Text(
                                meal.name ?? 'N/A',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(meal.description ?? 'No description'),
                            ),
                          );
                        },
                      )
                          : Center(child: Text('No meals found')),
                    ),
                  ),
                ],
              );
            } else if (state is MealPlanError) {
              return Center(child: Text(MessageError.errorCommon));
            } else {
              return Center(child: Text('No meals found'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMealDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildCalendar(BuildContext context, MealPlanLoaded state) {
    DateTime _focusedDay = DateTime.now();
    DateTime? _selectedDay = DateTime.now();

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          decoration: const BoxDecoration(color: Color(0x9CC3FCDF)),
          child: TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            eventLoader: (day) => state.meals,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = selectedDay;
              });
              // Trigger event to load meals for the selected day
              context.read<MealPlanBloc>().add(
                LoadMealsForDay(context, selectedDay.millisecondsSinceEpoch ~/ 1000),
              );
            },
            onFormatChanged: (format) {
              // Handle format change if necessary
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    bottom: 1,
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
        );
      },
    );
  }

}
