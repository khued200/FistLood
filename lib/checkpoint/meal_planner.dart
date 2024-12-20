// import 'package:flutter/material.dart';
// import 'package:shopping_conv/blocs/navigation/navigation.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:shopping_conv/ui/app_routes.dart';
// import 'package:shopping_conv/ui/helper_func.dart';
// import 'package:shopping_conv/ui/meal_plan/recipe_search.dart';
// import '../utils.dart';

// class MealPlanScreen extends StatefulWidget {
//   @override
//   _MealPlanScreenState createState() => _MealPlanScreenState();
// }

// class _MealPlanScreenState extends State<MealPlanScreen> {
//   bool isMealAdded = false;
//   late final ValueNotifier<List<DishesPlanned>> _selectedDishes;
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
//       .toggledOff; // Can be toggled on/off by longpressing a date
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   DateTime? _rangeStart;
//   DateTime? _rangeEnd;

//   @override
//   void initState() {
//     super.initState();

//     _selectedDay = _focusedDay;
//     _selectedDishes = ValueNotifier(_getMealsForDay(_selectedDay!));
//   }

//   @override
//   void dispose() {
//     _selectedDishes.dispose();
//     super.dispose();
//   }

//   List<DishesPlanned> _getMealsForDay(DateTime day) {
//     // Implementation example
//     return kMeals[day] ?? [];
//   }

//   // List<DishesPlanned> _getEventsForRange(DateTime start, DateTime end) {
//   //   // Implementation example
//   //   final days = daysInRange(start, end);

//   //   return [
//   //     for (final d in days) ..._getEventsForDay(d),
//   //   ];
//   // }

//   void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
//     if (!isSameDay(_selectedDay, selectedDay)) {
//       setState(() {
//         _selectedDay = selectedDay;
//         _focusedDay = focusedDay;
//         _rangeStart = null; // Important to clean those
//         _rangeEnd = null;
//         // _rangeSelectionMode = RangeSelectionMode.toggledOff;
//       });

//       _selectedDishes.value = _getMealsForDay(selectedDay);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0x9C9EEDFF),
//         elevation: 0,
//         leading: null,
//         title: Text(
//           'Today',
//           style: TextStyle(color: Colors.black, fontSize: 20),
//         ),
//         centerTitle: false,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.more_vert, color: Colors.black),
//             onPressed: () {
//               // More options action
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Calendar section
//           Container(
//             decoration: const BoxDecoration(
//               color: Color(0x9CC3FCDF),
//             ),
//             child:TableCalendar(
//               firstDay: DateTime.utc(2010, 10, 16),
//               lastDay: DateTime.utc(2030, 3, 14),
//               focusedDay: _focusedDay,
//               calendarFormat: _calendarFormat,
//               selectedDayPredicate: (day) {
//                 // Use `selectedDayPredicate` to determine which day is currently selected.
//                 // If this returns true, then `day` will be marked as selected.

//                 // Using `isSameDay` is recommended to disregard
//                 // the time-part of compared DateTime objects.
//                 return isSameDay(_selectedDay, day);
//               },
//               rangeStartDay: _rangeStart,
//               rangeEndDay: _rangeEnd,
//               rangeSelectionMode: _rangeSelectionMode,
//               eventLoader: _getMealsForDay,
//               startingDayOfWeek: StartingDayOfWeek.monday,
//               calendarStyle: CalendarStyle(
//                 // Use `CalendarStyle` to customize the UI
//                 outsideDaysVisible: false,
//               ),
//               onDaySelected: _onDaySelected,
//               // onDaySelected: (selectedDay, focusedDay) {
//               //   if (!isSameDay(_selectedDay, selectedDay)) {
//               //     // Call `setState()` when updating the selected day
//               //     setState(() {
//               //       _selectedDay = selectedDay;
//               //       _focusedDay = focusedDay;
//               //     });
//               //   }
//               // },
//               onFormatChanged: (format) {
//                 if (_calendarFormat != format) {
//                   // Call `setState()` when updating calendar format
//                   setState(() {
//                     _calendarFormat = format;
//                   });
//                 }
//               },
//               onPageChanged: (focusedDay) {
//                 // No need to call `setState()` here
//                 _focusedDay = focusedDay;
//               },
//               calendarBuilders: CalendarBuilders(
//                 markerBuilder: (context, date, events) {
//                   if (events.isEmpty) return null;
//                   final dishesPlannedList = events.cast<DishesPlanned>();
//                   // Create colored dots for each event
//                   return Positioned(
//                     bottom: 1,
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: dishesPlannedList .map((event) {
//                         final color = getMealTypeColor(event.mealType);
//                         return Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 1.0),
//                           width: 8,
//                           height: 8,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: color,
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
          
//           // Add recipe and Add meal buttons
//           Row(
            
//             children: [
//               Expanded(
//                 child: 
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Color(0x9CE5DFDF),
//                     border: Border(
//                       top: BorderSide(color: Color(0x9C837575),width: 2),
//                       left: BorderSide(color: Color(0x9C837575),width: 2),
//                       right: BorderSide(color: Color(0x9C837575),width: 1),
//                       bottom: BorderSide(color: Color(0x9C837575),width: 2),
//                     )
//                   ),
          
//                   child: TextButton( 
//                     onPressed: () {
//                       // Add recipe action
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => RecipeSearchScreen(),
//                         ),
//                       );
//                     },
//                     child: Text('Add recipe', style: TextStyle(color: Colors.black)),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Color(0x9CE5DFDF),
//                     border: Border(
//                       top: BorderSide(color: Color(0x9C837575),width: 2),
//                       left: BorderSide(color: Color(0x9C837575),width: 1),
//                       right: BorderSide(color: Color(0x9C837575),width: 2),
//                       bottom: BorderSide(color: Color(0x9C837575),width: 2),
//                     )
//                   ),
          
//                   child: TextButton(
//                     onPressed: () {
//                       setState(() {
//                         isMealAdded = !isMealAdded;
//                       });
//                     },
//                     // style: TextButton.styleFrom(
//                     //   backgroundColor: Color.fromARGB(156, 20, 15, 15),
//                     // ),
//                     child: Text('Add meal', style: TextStyle(color: Colors.black)),
//                   ),
//                 ) 
//               ),
//             ],
//           ),
//           Expanded(child: ValueListenableBuilder<List<DishesPlanned>>(
//               valueListenable: _selectedDishes,
//               builder: (context, value, _) {
//                 return ListView.builder(
//                   itemCount: value.length,
//                   itemBuilder: (context, index) {
//                     return MealCard(mealName: value[index].toGetMealName(), 
//                             mealType: value[index].toGetMealType());
//                   },
//                 );
//               },
//             ),)
          
//         ],
//       ),

//       // Bottom navigation bar
//       // bottomNavigationBar: CustomBottomNavigation()
//     );
//   }
// }


// class MealCard extends StatelessWidget {
//   final String mealName;
//   final String mealType;

//   const MealCard({required this.mealName, required this.mealType});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       padding: const EdgeInsets.only(left: 10),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         border: Border(
//           bottom: BorderSide(color: Colors.grey),
//         ),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               children: [
//                 Text(mealName,style: const TextStyle(fontSize: 16),),
//                 Text(
//                   mealType,
//                   style: TextStyle(
//                     fontSize: 12, 
//                     color: mealType== 'Breakfast'
//                           ? const Color(0x9C0066FF): mealType== 'Lunch'?
//                                       const Color(0x9CFF8000): const Color(0x9CFF0000),
//                   ),
//                 ),
//               ]
//             )
//           ),
//           IconButton(
//             icon: const Icon(Icons.arrow_forward_ios, size: 18),
//             onPressed: () {
//               // Edit functionality
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Color _getMealTypeColor(String mealType) {
// //   switch (mealType) {
// //     case 'Breakfast':
// //       return const Color(0xFF0066FF); // Blue
// //     case 'Lunch':
// //       return const Color(0xFFFF8000); // Orange
// //     case 'Dinner':
// //       return const Color(0xFFFF0000); // Red
// //     default:
// //       return const Color(0xFF808080); // Gray for undefined meal types
// //   }
// // }