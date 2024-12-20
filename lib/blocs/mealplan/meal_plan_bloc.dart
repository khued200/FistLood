import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_conv/models/meal_plan_models.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_event.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_state.dart';


class MealPlanBloc extends Bloc<MealPlanEvent, MealPlanState> {
  MealPlanBloc() : super(MealPlanInitial()) {
    on<LoadMealsForDay>(_onLoadMealsForDay);
    on<AddMealPlan>(_onAddMealPlan);
  }

  void _onLoadMealsForDay(LoadMealsForDay event, Emitter<MealPlanState> emit) async {
    emit(MealPlanLoading());
    try {
      final meals = _getMealsForDay(event.selectedDay);
      emit(MealPlanLoaded(meals, event.selectedDay));
    } catch (e) {
      emit(MealPlanError(e.toString()));
    }
  }

  void _onAddMealPlan(AddMealPlan event, Emitter<MealPlanState> emit) async {
    try {
      // Add meal to storage/database
      final updatedMeals = _getMealsForDay(event.day);
      emit(MealPlanLoaded(updatedMeals, event.day));
    } catch (e) {
      emit(MealPlanError(e.toString()));
    }
  }

  List<DishesPlanned> _getMealsForDay(DateTime day) {
    // Implementation example - replace with actual data source
    return kMeals[day] ?? [];
  }
}