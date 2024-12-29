import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/utils/auth_storage_util.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(Unauthenticated()) {
    on<CheckAuthentication>(_onCheckAuthentication);
    on<LoginEvent>(_onLogin);
  }

  void _onCheckAuthentication(
      CheckAuthentication event, Emitter<AuthState> emit) {
    // Replace with your logic to check authentication
    var isAuthenticated = AuthStorage.isAuthenticated();
    if (isAuthenticated == true) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  void _onLogin(LoginEvent event, Emitter<AuthState> emit) {
    // Update the authentication state to logged in
    emit(Authenticated());
  }
}
