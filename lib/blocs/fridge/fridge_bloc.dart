import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/data/services/fridge_service.dart';
import 'fridge_event.dart';
import 'fridge_state.dart';

class FridgeBloc extends Bloc<FridgeEvent, FridgeState> {
  final FridgeService fridgeService;

  FridgeBloc({required this.fridgeService}) : super(FridgeInitial()) {
    on<FetchFridgeItems>(_onFetchFridgeItems);
    on<AddFridgeItem>(_addFridgeItem);
  }

  Future<void> _onFetchFridgeItems(FetchFridgeItems event, Emitter<FridgeState> emit) async {
    emit(FridgeLoading());
    try {
      final response = await fridgeService.getFridgeItem(event.context);
      final items = response.data;
      emit(FridgeLoaded(items));
    } catch (e) {
      emit(FridgeError(e.toString()));
    }
  }
  Future<void> _addFridgeItem(AddFridgeItem event, Emitter<FridgeState> emit) async {

    try {
     var response = await fridgeService.addFridgeItem(event.context, event.foodId, event.quantity, event.expiredDate, event.note);
     if (response.code == 200) {
       emit(FridgeItemAdded());
     }
     add(FetchFridgeItems(context: event.context)); // Re-fetch items after adding
    } catch (e) {
      emit(FridgeError(e.toString()));
    }
  }
}
