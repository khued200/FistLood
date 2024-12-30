import 'package:flutter/material.dart';
import 'package:shopping_conv/data/services/auth_service.dart';
import 'package:shopping_conv/ui/register/request_otp_screen.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthService authService;

  RegisterViewModel({required this.authService});

  bool isLoading = false;
  String? errorMessage;

  Future<bool> register({
    required BuildContext context,
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
      if (registeredUser.data.isVerified == false){
        Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerificationScreen(email: email)));
      }
      return true;
    } catch (error) {
      errorMessage = error.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
