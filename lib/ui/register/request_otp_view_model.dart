import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_conv/data/services/auth_service.dart';
import 'package:shopping_conv/ui/app_routes.dart';

class RequestOtpViewModel extends ChangeNotifier{
  final AuthService authService;
  RequestOtpViewModel({required this.authService});
  bool isLoading = false;
  String? errorMessage;
  Future<void> sendOTP({required BuildContext context,
    required String email,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final otpResponse = await authService.sendOTP(
        email: email,
      );
      if (otpResponse.code == 200){

      }
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  Future<void> verifyOTP({required BuildContext context,
    required String email,
    required String otp,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final otpResponse = await authService.verifyOTP(
        email: email,
        otp: otp,
      );
      if (otpResponse.code == 200){
        Navigator.pushReplacementNamed(context, AppRoutes.register);
      }
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}