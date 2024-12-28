import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/data/services/food_service.dart';
import 'food_event.dart';
import 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodService foodService;

  FoodBloc({required this.foodService}) : super(FoodInitial()) {
    on<FetchFoodItems>(_onFetchFoodItems);
    on<AddFoodItem>(_onAddFoodItem);
  }

  Future<void> _onFetchFoodItems( FetchFoodItems event, Emitter<FoodState> emit) async {
    emit(FoodLoading());
    try {
      final items = await foodService.getAllFood(event.context);
      emit(FoodLoaded(items.data));
    } catch (e) {
      emit(FoodError(e.toString()));
    }
  }

  Future<void> _onAddFoodItem(AddFoodItem event, Emitter<FoodState> emit) async {
    try {
      // await foodService.addFoodItem(event.name, event.category);
      add(FetchFoodItems(context: event.context)); // Re-fetch items after adding
    } catch (e) {
      emit(FoodError(e.toString()));
    }
  }
}
