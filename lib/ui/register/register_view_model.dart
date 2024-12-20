import 'package:flutter/material.dart';
import 'package:shopping_conv/data/services/auth_service.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthService authService;

  RegisterViewModel({required this.authService});

  bool isLoading = false;
  String? errorMessage;

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String language,
    required String timezone,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final registeredUser = await authService.registerUser(
        email: email,
        password: password,
        name: name,
        language: language,
        timezone: timezone,
      );
      print('Registered user: $registeredUser');
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
