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
  final String type;
  final int? categoryId;
  final int unitId;
  final String? imageBase64;

  AddFoodItem({
    required this.context,
    required this.name,
    required this.type,
    required this.unitId,
    this.categoryId,
    this.imageBase64,
  });

  @override
  List<Object?> get props => [context, name, type, categoryId, unitId, imageBase64];
}
