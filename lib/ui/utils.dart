// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class DishesPlanned {
  final String mealName;
  final String mealType;
  const DishesPlanned(this.mealName, this.mealType);

  // @override
  String toGetMealName() => mealName;
  String toGetMealType() => mealType;

}


// /// Example events.
// ///
// /// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
var kMeals = LinkedHashMap<DateTime, List<DishesPlanned>>(
  equals: isSameDay,
  hashCode: getHashCode,
);

// var kMeals = LinkedHashMap<DateTime, List<DishesPlanned>>(
//   equals: isSameDay,
//   hashCode: getHashCode,
// )..addAll(_kEventSource);

// DateTime today = DateTime.now();
// DateTime tomorrow = today.add(Duration(days: 1));
// DateTime nextWeek = today.add(Duration(days: 7));


// final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
//     key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
//     value: (item) => List.generate(
//         item % 4 + 1, (index) => DishesPlanned('Chicken','Lunch')))
//   ..addAll({
//     kToday: [
//       DishesPlanned("Grilled Chicken", "Breakfast"),
//       DishesPlanned("Spaghetti Carbonara", "Dinner"),
//     ],
//   });


int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

// // /// Returns a list of [DateTime] objects from [first] to [last], inclusive.
// // List<DateTime> daysInRange(DateTime first, DateTime last) {
// //   final dayCount = last.difference(first).inDays + 1;
// //   return List.generate(
// //     dayCount,
// //     (index) => DateTime.utc(first.year, first.month, first.day + index),
// //   );
// // }

// final kToday = DateTime.now();
// final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
// final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

