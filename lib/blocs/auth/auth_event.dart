import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckAuthentication extends AuthEvent {}

class LoginEvent extends AuthEvent {}
