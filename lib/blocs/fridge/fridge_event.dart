import 'package:equatable/equatable.dart';

abstract class FridgeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchFridgeItems extends FridgeEvent {}
