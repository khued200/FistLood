import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DishesPlanned {
  final String mealName;
  final String mealType;
  const DishesPlanned(this.mealName, this.mealType);

  // @override
  String toGetMealName() => mealName;
  String toGetMealType() => mealType;

}

var kMeals = LinkedHashMap<DateTime, List<DishesPlanned>>(
  equals: isSameDay,
  hashCode: getHashCode,
);

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

class Recipe{
  
}