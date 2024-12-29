import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_conv/models/meal_plan_models.dart';

abstract class MealPlanEvent extends Equatable {
  const MealPlanEvent();

  @override
  List<Object?> get props => [];
}

class LoadMealsForDay extends MealPlanEvent {
  final BuildContext context;
  final int selectedDay;

  const LoadMealsForDay(this.context, this.selectedDay);

  @override
  List<Object?> get props => [context, selectedDay];
}

class AddMealPlan extends MealPlanEvent {
  final String name;
  final String description;
  final int schedule;
  final String? status;
  final List<int> foodIds;

  final BuildContext context;
  AddMealPlan(
      {required this.context,
      required this.name,
      required this.description,
      required this.schedule,
       this.status,
      required this.foodIds});

  @override
  List<Object?> get props => [name, description, schedule, status, foodIds];
}