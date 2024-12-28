import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/data/services/fridge_service.dart';
import 'fridge_event.dart';
import 'fridge_state.dart';

class FridgeBloc extends Bloc<FridgeEvent, FridgeState> {
  final FridgeService fridgeService;

  FridgeBloc({required this.fridgeService}) : super(FridgeInitial()) {
    on<FetchFridgeItems>(_onFetchFridgeItems);
  }

  Future<void> _onFetchFridgeItems(FetchFridgeItems event, Emitter<FridgeState> emit) async {
    emit(FridgeLoading());
    try {
      final response = await fridgeService.getFridgeItem();
      final items = response.data;
      emit(FridgeLoaded(items));
    } catch (e) {
      emit(FridgeError(e.toString()));
    }
  }
}
