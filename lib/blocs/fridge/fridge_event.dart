import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_conv/data/model/response/get_fridge_item_response.dart';

abstract class FridgeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchFridgeItems extends FridgeEvent {
  final BuildContext context;
  FetchFridgeItems({required this.context});
  @override
  List<Object?> get props => [context];
}
class AddFridgeItem extends FridgeEvent {
  final BuildContext context;
  final int foodId;
  final int quantity;
  final int expiredDate;
  final String? note;
  AddFridgeItem({required this.context, required this.foodId, required this.quantity, required this.expiredDate, this.note});
  @override
  List<Object?> get props => [context, foodId, quantity, expiredDate, note];
}