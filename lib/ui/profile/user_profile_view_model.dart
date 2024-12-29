import 'package:flutter/material.dart';
import 'package:shopping_conv/data/model/response/get_user_profile_response.dart';
import 'package:shopping_conv/data/services/auth_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthService apiService;

  ProfileViewModel({required this.apiService});

  GetUserProfileData? _profile;
  bool _isLoading = false;
  String? _errorMessage;

  GetUserProfileData? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProfile(BuildContext context) async {
    if (_profile != null) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      var response = await apiService.getUserProfile(context);
      _profile = response.data;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> logout(BuildContext context) async {
    // Clear user data and navigate to the login screen
    // Implement your logout logic here
    await apiService.logout(context);
  }
}
