import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_conv/data/services/meal_service.dart';
import 'package:shopping_conv/models/meal_plan_models.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_event.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_state.dart';


class MealPlanBloc extends Bloc<MealPlanEvent, MealPlanState> {
  final MealService mealService;

  MealPlanBloc({required this.mealService}) : super(MealPlanInitial()){
    on<LoadMealsForDay>(_onLoadMealsForDay);
    on<AddMealPlan>(_onAddMealPlan);
  }

  void _onLoadMealsForDay(LoadMealsForDay event, Emitter<MealPlanState> emit) async {
    emit(MealPlanLoading());
    try {
      final response = await mealService.getListMeal(event.context, event.selectedDay);
      emit(MealPlanLoaded(response.data, event.selectedDay));
    } catch (e) {
      emit(MealPlanError(e.toString()));
    }
  }

  void _onAddMealPlan(AddMealPlan event, Emitter<MealPlanState> emit) async {
    try {
       await mealService.createMeal(event.context, event.name, event.description, event.schedule, event.status!, event.foodIds);
      emit(MealPlanAdded());
    } catch (e) {
      emit(MealPlanError(e.toString()));
    }
  }

  List<DishesPlanned> _getMealsForDay(DateTime day) {
    // Implementation example - replace with actual data source
    return kMeals[day] ?? [];
  }
}