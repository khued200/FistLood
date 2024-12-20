import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class GroceryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddGroceryItem extends GroceryEvent {
  final String item;
  final String quantity;
  final String category;

  AddGroceryItem({
    required this.item, 
    required this.quantity, 
    required this.category
  });

  @override
  List<Object> get props => [item, quantity, category];
}

class ToggleAddItemMode extends GroceryEvent {
  final bool isAdding;
  
  ToggleAddItemMode(this.isAdding);

  @override
  List<Object> get props => [isAdding];
}