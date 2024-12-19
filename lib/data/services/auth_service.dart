import 'package:shopping_conv/data/model/request/register_request.dart';
import 'package:shopping_conv/data/model/response/login_user_response.dart';
import 'package:shopping_conv/data/model/response/register_user_response.dart';
import 'package:shopping_conv/data/services/utils/api_instance.dart';
import 'package:shopping_conv/data/services/utils/device_info.dart';

import '../model/request/login_request.dart';

class AuthService {
  static const registerUserPath = '/authen-service/public/v1/user';
  static const loginPath = '/authen-service/public/v1/user/login';
  final ApiService apiService;
  AuthService({required this.apiService});
  Future<RegisterUserResponse> registerUser({
    required String email,
    required String password,
    required String name,
    required String language,
    required String timezone,
  }) async {
    final deviceId = getDeviceId() as String;
    final registerRequest = RegisterRequestModel(email: email,
        password: password,
        name: name,
        language: language,
        timezone: timezone,
        deviceId: deviceId);
    final requestBody = registerRequest.toJson();
    try {
      final response = await apiService.dio.post(
        registerUserPath,
        data: requestBody,
      );
      return RegisterUserResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
  Future<LoginUserResponse> loginUser({
    required String email,
    required String password,
  }) async {
    final loginRequest = LoginRequestModel(email: email, password: password);
    final requestBody = loginRequest.toJson();
    try {
      final response = await apiService.dio.post(
        loginPath,
        data: requestBody,
      );
      return LoginUserResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}