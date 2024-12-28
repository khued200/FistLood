import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/data/model/response/get_user_profile_response.dart';
import 'package:shopping_conv/data/services/auth_service.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthService authService;

  ProfileBloc({required this.authService}) : super(ProfileInitial()) {
    on<FetchProfile>(_onFetchProfile);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onFetchProfile(FetchProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      var response = await authService.getUserProfile(event.context);
      emit(ProfileLoaded(profile: response.data));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<ProfileState> emit) async {
    try {
      await authService.logout(event.context);
      emit(LogoutSuccess());
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
