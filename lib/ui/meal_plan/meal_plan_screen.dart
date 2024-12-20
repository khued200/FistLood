import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shopping_conv/models/meal_plan_models.dart';
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
    return BlocProvider(
      create: (context) => MealPlanBloc()..add(LoadMealsForDay(DateTime.now())),
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
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x9C9EEDFF),
        elevation: 0,
        title:
            Text('Today', style: TextStyle(color: Colors.black, fontSize: 20)),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<MealPlanBloc, MealPlanState>(
        builder: (context, state) {
          if (state is MealPlanLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is MealPlanError) {
            return Center(child: Text(state.message));
          }

          if (state is MealPlanLoaded) {
            return Column(
              children: [
                _buildCalendar(context, state),
                _buildActionButtons(context),
                // _buildMealsList(state.meals),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget _buildCalendar(BuildContext context, MealPlanLoaded state) {
    return Container(
      decoration: const BoxDecoration(color: Color(0x9CC3FCDF)),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        eventLoader: (day) => state.meals,
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          context.read<MealPlanBloc>().add(LoadMealsForDay(selectedDay));
        },
        onFormatChanged: (format) {
          setState(() => _calendarFormat = format);
        },
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            // Implement marker builder
            return null;
          },
        ),
      ),
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
                // Add recipe action
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RecipeSearchScreen(),
                  ),
                );
              },
              child: Text('Add recipe', style: TextStyle(color: Colors.black)),
            ),
          ),
        ),
        Expanded(
            child: Container(
            decoration: BoxDecoration(
                color: Color(0x9CE5DFDF),
                border: Border(
                  top: BorderSide(color: Color(0x9C837575), width: 2),
                  left: BorderSide(color: Color(0x9C837575), width: 1),
                  right: BorderSide(color: Color(0x9C837575), width: 2),
                  bottom: BorderSide(color: Color(0x9C837575), width: 2),
                )),
            child: TextButton(
              onPressed: () {
                // setState(() {
                //   isMealAdded = !isMealAdded;
                // });
              },
            // style: TextButton.styleFrom(
            //   backgroundColor: Color.fromARGB(156, 20, 15, 15),
            // ),
            child: Text('Add meal', style: TextStyle(color: Colors.black)),
            ),
          )
        ),
      ],
    );
  }

  // Implement _buildActionButtons and _buildMealsList methods...
}
