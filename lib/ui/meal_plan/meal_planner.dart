import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/ui/helper_func.dart';

class MealPlanScreen extends StatefulWidget {
  @override
  _MealPlanScreenState createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  bool isMealAdded = false;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x9C9EEDFF),
        elevation: 0,
        title: Text(
          'Today',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // More options action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Calendar section
          Container(
            decoration: const BoxDecoration(
              color: Color(0x9CC3FCDF),
            ),
            child:TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                // Use `selectedDayPredicate` to determine which day is currently selected.
                // If this returns true, then `day` will be marked as selected.

                // Using `isSameDay` is recommended to disregard
                // the time-part of compared DateTime objects.
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  // Call `setState()` when updating the selected day
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  // Call `setState()` when updating calendar format
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                _focusedDay = focusedDay;
              },
            ),
          ),
          
          // Add recipe and Add meal buttons
          Row(
            
            children: [
              Expanded(
                child: 
                Container(
                  decoration: BoxDecoration(
                    color: Color(0x9CE5DFDF),
                    border: Border(
                      top: BorderSide(color: Color(0x9C837575),width: 2),
                      left: BorderSide(color: Color(0x9C837575),width: 2),
                      right: BorderSide(color: Color(0x9C837575),width: 1),
                      bottom: BorderSide(color: Color(0x9C837575),width: 2),
                    )
                  ),
          
                  child: TextButton( 
                    onPressed: () {
                      // Add recipe action
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
                      top: BorderSide(color: Color(0x9C837575),width: 2),
                      left: BorderSide(color: Color(0x9C837575),width: 1),
                      right: BorderSide(color: Color(0x9C837575),width: 2),
                      bottom: BorderSide(color: Color(0x9C837575),width: 2),
                    )
                  ),
          
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isMealAdded = !isMealAdded;
                      });
                    },
                    // style: TextButton.styleFrom(
                    //   backgroundColor: Color.fromARGB(156, 20, 15, 15),
                    // ),
                    child: Text('Add meal', style: TextStyle(color: Colors.black)),
                  ),
                ) 
              ),
            ],
          ),
          
        ],
      ),

      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: getCurrentIndex(context),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.groceryList, (route) => false);
              break;
            case 1:
              // Navigator.pushNamedAndRemoveUntil(context, AppRoutes.foodRecipes, (route) => false);
              break;
            case 2:
              // Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mealPlanner, (route) => false);
              break;
            case 3:
              // Navigator.pushNamedAndRemoveUntil(context, AppRoutes.settings, (route) => false);
              break;
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
      ),
    );
  }
}

class MealCard extends StatelessWidget {
  final String mealName;
  final String mealType;

  const MealCard({required this.mealName, required this.mealType});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(mealName),
        subtitle: Text(mealType),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
