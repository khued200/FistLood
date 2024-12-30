import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_conv/ui/meal_plan/widgets/meal_plan_models.dart';

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

class AddMealToPlan extends MealPlanEvent {
  final Recipe recipe;
  final DateTime day;

  const AddMealToPlan(this.recipe, this.day);

  @override
  List<Object?> get props => [recipe, day];
}

class DeleteMeal extends MealPlanEvent {
  final DishesPlanned meal;
  final DateTime day;

  DeleteMeal(this.meal, this.day);

  @override
  List<Object?> get props => [meal,day];
}