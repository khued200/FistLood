import 'package:equatable/equatable.dart';
import 'package:shopping_conv/data/model/response/get_list_food_response.dart';


abstract class FoodState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FoodInitial extends FoodState {}

class FoodLoading extends FoodState {}

class FoodLoaded extends FoodState {
  final List<FoodData> items;

  FoodLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class FoodError extends FoodState {
  final String message;

  FoodError(this.message);

  @override
  List<Object?> get props => [message];
}
