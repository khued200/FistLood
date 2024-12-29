import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/data/services/food_service.dart';
import 'food_event.dart';
import 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodService foodService;

  FoodBloc({required this.foodService}) : super(FoodInitial()) {
    on<FetchFoodItems>(_onFetchFoodItems);
    on<AddFoodItem>(_onAddFoodItem);
    on<FetchFoodDetail>(_onFetchFoodDetail);
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
      await foodService.createFood(event.context,
          name: event.name,
          type: event.type,
          unitId: event.unitId,
          categoryId: event.categoryId,
          imageUrl: event.imageBase64);
      add(FetchFoodItems(context: event.context)); // Re-fetch items after adding
    } catch (e) {
      emit(FoodError(e.toString()));
    }
  }
  Future<void> _onFetchFoodDetail(
      FetchFoodDetail event, Emitter<FoodState> emit) async {
    emit(FoodDetailLoading());
    try {
      final resp = await foodService.getFoodDetail(event.context, event.id);
      emit(FoodDetailLoaded(resp.data));
    } catch (e) {
      emit(FoodDetailError(e.toString()));
    }
  }
}
