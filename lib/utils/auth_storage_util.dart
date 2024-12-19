import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const _accessTokenKey = 'auth_access_token';
  static const _refreshTokenKey = 'auth_refresh_token';
  static const _isAuthKey = 'is_authenticated';

  // Save token and authentication status
  static Future<void> saveAuthToken(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
    await prefs.setBool(_isAuthKey, true);
  }

  // Get token
  static Future<String?> getAuthAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }
  //Get refresh token
  static Future<String?> getAuthRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  // Check if user is authenticated
  static Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isAuthKey) ?? false;
  }

  // Clear token and authentication status
  static Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.setBool(_isAuthKey, false);
  }
}
