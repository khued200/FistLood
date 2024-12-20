import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_conv/models/grocery_list_models.dart';
import '../grocery/grocery_list_event.dart';
import '../grocery/grocery_list_state.dart';

class GroceryBloc extends Bloc<GroceryEvent, GroceryState> {
  GroceryBloc() : super(const GroceryState(groceryLists: [])) {
    on<AddGroceryItem>(_onAddGroceryItem);
    on<ToggleAddItemMode>(_onToggleAddItemMode);
  }

  void _onAddGroceryItem(AddGroceryItem event, Emitter<GroceryState> emit) {
    try {
      final currentLists = List<GroceryList>.from(state.groceryLists);
      
      // Find existing category or create new one
      var categoryList = currentLists.firstWhere(
        (list) => list.category == event.category,
        orElse: () {
          final newList = GroceryList(
            category: event.category,
            grocerylist: [],
          );
          currentLists.add(newList);
          return newList;
        },
      );

      // Add new item
      categoryList.grocerylist.add(GroceryItem(
        item: event.item,
        quantity: event.quantity,
      ));

      emit(state.copyWith(
        groceryLists: currentLists,
        isAddingItem: false,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void _onToggleAddItemMode(ToggleAddItemMode event, Emitter<GroceryState> emit) {
    emit(state.copyWith(isAddingItem: event.isAdding));
  }
}