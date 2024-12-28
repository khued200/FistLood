import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class FoodEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchFoodItems extends FoodEvent {
  final BuildContext context;
  FetchFoodItems({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddFoodItem extends FoodEvent {
  final BuildContext context;
  final String name;
  final String category;
  final String unit;
  final String imageBase64;

  AddFoodItem({
    required this.context,
    required this.name,
    required this.category,
    required this.unit,
    required this.imageBase64,
  });

  @override
  List<Object?> get props => [context, name, category, unit, imageBase64];
}
