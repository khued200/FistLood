import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ProfileEvent extends Equatable {

  @override
  List<Object?> get props => [];
}

class FetchProfile extends ProfileEvent {
  final BuildContext context;
  FetchProfile(this.context);
  @override
  List<Object?> get props => [context];
}

class LogoutEvent extends ProfileEvent {
  final BuildContext context;
  LogoutEvent(this.context);
  @override
  List<Object?> get props => [context];
}
