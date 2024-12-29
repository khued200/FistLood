import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/ui/meal_plan/widgets/meal_plan_models.dart';

// abstract class MealPlanState extends Equatable   {
//   const MealPlanState();

//   @override
//   List<Object?> get props => [];
// }

// class MealPlanInitial extends MealPlanState {}

// class MealPlanLoading extends MealPlanState {}

class MealPlanState extends Equatable {
  final LinkedHashMap<DateTime, List<DishesPlanned>> meals;
  final String error;

  const MealPlanState({
    required this.meals,
    this.error = '',
  });

  MealPlanState copyWith({
    LinkedHashMap<DateTime, List<DishesPlanned>>? meals,
    String? error,
  }) {
    return MealPlanState(
      meals: meals ?? this.meals,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [meals, error];

  @override
  String toString() {
    return 'MealPlanState(meals: $meals, error: $error)';
  }
}

class MealPlanError extends Equatable {
  final String message;

  const MealPlanError(this.message);

  @override
  List<Object?> get props => [message];
}