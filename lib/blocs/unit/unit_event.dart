import 'package:equatable/equatable.dart';

abstract class UnitEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUnits extends UnitEvent {}
