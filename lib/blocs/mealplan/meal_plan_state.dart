import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_conv/models/meal_plan_models.dart';

abstract class MealPlanState extends Equatable {
  const MealPlanState();

  @override
  List<Object?> get props => [];
}

class MealPlanInitial extends MealPlanState {}

class MealPlanLoading extends MealPlanState {}

class MealPlanLoaded extends MealPlanState {
  final List<DishesPlanned> meals;
  final DateTime selectedDay;

  const MealPlanLoaded(this.meals, this.selectedDay);

  @override
  List<Object?> get props => [meals, selectedDay];
}

class MealPlanError extends MealPlanState {
  final String message;

  const MealPlanError(this.message);

  @override
  List<Object?> get props => [message];
}