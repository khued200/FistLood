import '../../models/grocery_list_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class GroceryState extends Equatable {
  final List<GroceryList> groceryLists;
  final bool isAddingItem;
  final String error;

  const GroceryState({
    required this.groceryLists,
    this.isAddingItem = false,
    this.error = '',
  });

  GroceryState copyWith({
    List<GroceryList>? groceryLists,
    bool? isAddingItem,
    String? error,
  }) {
    return GroceryState(
      groceryLists: groceryLists ?? this.groceryLists,
      isAddingItem: isAddingItem ?? this.isAddingItem,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [groceryLists, isAddingItem, error];
}
