import 'dart:collection';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_conv/ui/meal_plan/widgets/meal_plan_models.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_event.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_state.dart';
import 'package:table_calendar/table_calendar.dart';


import 'dart:collection';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/ui/meal_plan/widgets/meal_plan_models.dart';

import 'dart:collection';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_conv/ui/meal_plan/widgets/meal_plan_models.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_event.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_state.dart';
import 'package:table_calendar/table_calendar.dart';

import 'dart:collection';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_conv/ui/meal_plan/widgets/meal_plan_models.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_event.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_state.dart';
import 'package:table_calendar/table_calendar.dart';

class MealPlanBloc extends Bloc<MealPlanEvent, MealPlanState> {
  // Store meals in the bloc instance to persist between state changes
  final LinkedHashMap<DateTime, List<DishesPlanned>> _mealsStore = LinkedHashMap<DateTime, List<DishesPlanned>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  MealPlanBloc() : super(MealPlanState(meals: LinkedHashMap<DateTime, List<DishesPlanned>>(
    equals: isSameDay,
    hashCode: getHashCode,
  ))) {
    on<LoadMealsForDay>(_onLoadMealsForDay);
    on<AddMealToPlan>(_onAddMealToPlan);
    on<DeleteMeal>(_onDeleteMeal);
  }

  void _onLoadMealsForDay(LoadMealsForDay event, Emitter<MealPlanState> emit) {
    try {
      // Use the stored meals instead of empty state
      // print(_mealsStore);
      emit(MealPlanState(meals: LinkedHashMap<DateTime, List<DishesPlanned>>.from(_mealsStore)));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void _onAddMealToPlan(AddMealToPlan event, Emitter<MealPlanState> emit) {
    try {
      final normalizedDate = _normalizeDate(event.day);
      final meal = DishesPlanned(event.recipe.name, event.recipe.type);

      // Update the stored meals
      final dayMeals = List<DishesPlanned>.from(_mealsStore[normalizedDate] ?? []);
      dayMeals.add(meal);
      _mealsStore[normalizedDate] = dayMeals;
      // print(_mealsStore);
      // Emit new state with all stored meals
      emit(MealPlanState(meals: LinkedHashMap<DateTime, List<DishesPlanned>>.from(_mealsStore)));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void _onDeleteMeal(DeleteMeal event, Emitter<MealPlanState> emit) {
    try {
      final normalizedDate = _normalizeDate(event.day);
      final currentMeals = List<DishesPlanned>.from(_mealsStore[normalizedDate] ?? []);

      // Remove the meal from the list
      currentMeals.removeWhere((meal) => meal == event.meal);
      _mealsStore[normalizedDate] = currentMeals;
      // Update the state with the new meal list
      emit(MealPlanState(meals: LinkedHashMap<DateTime, List<DishesPlanned>>.from(_mealsStore)));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}