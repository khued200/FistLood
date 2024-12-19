import 'package:flutter/cupertino.dart';
import 'package:shopping_conv/data/services/auth_service.dart';
import 'package:shopping_conv/ui/app_routes.dart';
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
      await AuthStorage.saveAuthToken(loginUser.data.accessToken, loginUser.data.refreshToken);
      Navigator.pushNamed(context, AppRoutes.groceryList);
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}