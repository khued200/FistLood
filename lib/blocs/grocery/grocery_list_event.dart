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

class EditGroceryItem extends GroceryEvent {
  final String oldItem;
  final String newItem;
  final String newQuantity;
  final String oldCategory;
  final String newCategory;

  EditGroceryItem({
    required this.oldItem,
    required this.newItem,
    required this.newQuantity,
    required this.oldCategory,
    required this.newCategory,
  });

  @override
  List<Object> get props => [oldItem, oldCategory, newItem, newQuantity, newCategory];
  // List<Object> get props => [oldItem, newItem, newQuantity];

}

class DeleteGroceryItem extends GroceryEvent {
  final String item;
  final String category;

  DeleteGroceryItem({
    required this.item,
    required this.category,
  });

  @override
  List<Object> get props => [item, category];
}