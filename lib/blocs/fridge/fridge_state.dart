import 'package:equatable/equatable.dart';
import 'package:shopping_conv/data/model/response/get_fridge_item_response.dart';


abstract class FridgeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FridgeInitial extends FridgeState {}

class FridgeLoading extends FridgeState {}

class FridgeLoaded extends FridgeState {
  final List<GetFridgeItemData> items;

  FridgeLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class FridgeError extends FridgeState {
  final String message;

  FridgeError(this.message);

  @override
  List<Object?> get props => [message];
}
