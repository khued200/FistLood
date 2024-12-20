import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_conv/models/meal_plan_models.dart';

abstract class MealPlanEvent extends Equatable {
  const MealPlanEvent();

  @override
  List<Object?> get props => [];
}

class LoadMealsForDay extends MealPlanEvent {
  final DateTime selectedDay;

  const LoadMealsForDay(this.selectedDay);

  @override
  List<Object?> get props => [selectedDay];
}

class AddMealPlan extends MealPlanEvent {
  final DishesPlanned meal;
  final DateTime day;

  const AddMealPlan(this.meal, this.day);

  @override
  List<Object?> get props => [meal, day];
}