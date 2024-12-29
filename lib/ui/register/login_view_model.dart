import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_conv/data/services/auth_service.dart';
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/ui/home_screen.dart';
import 'package:shopping_conv/utils/auth_storage_util.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService authService;
  LoginViewModel({required this.authService});
  bool isLoading = false;
  String? errorMessage;

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final loginUser = await authService.loginUser(
        email: email,
        password: password,
      );
      //save token
      print(email);
      print(password);
      await AuthStorage.saveAuthToken(loginUser.data.accessToken, loginUser.data.refreshToken);
      print('auth access');
      Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
      
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}