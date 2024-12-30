import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_conv/data/services/auth_service.dart';
import 'package:shopping_conv/ui/app_routes.dart';

class RequestOtpViewModel extends ChangeNotifier{
  final AuthService authService;
  RequestOtpViewModel({required this.authService});
  bool isLoading = false;
  String? errorMessage;
  Future<bool> sendOTP({required BuildContext context,
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
        return true;
      }
      return false;
    } catch (error) {
      errorMessage = error.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  Future<bool> verifyOTP({required BuildContext context,
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