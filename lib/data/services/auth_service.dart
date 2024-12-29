import 'package:flutter/cupertino.dart';
import 'package:shopping_conv/data/model/request/otp_request.dart';
import 'package:shopping_conv/data/model/request/otp_verify.dart';
import 'package:shopping_conv/data/model/request/register_request.dart';
import 'package:shopping_conv/data/model/response/get_user_profile_response.dart';
import 'package:shopping_conv/data/model/response/login_user_response.dart';
import 'package:shopping_conv/data/model/response/otp_response.dart';
import 'package:shopping_conv/data/model/response/register_user_response.dart';
import 'package:shopping_conv/data/services/utils/api_instance.dart';
import 'package:shopping_conv/data/services/utils/device_info.dart';
import 'package:dio/dio.dart';
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/utils/auth_storage_util.dart';


import '../model/request/login_request.dart';

class AuthService {
  static const registerUserPath = '/authen-service/public/v1/user';
  static const loginPath = '/authen-service/public/v1/user/login';
  static const SendOTPPath = '/authen-service/public/v1/user/send-verification-code';
  static const VerifyOTPPath = '/authen-service/public/v1/user/verify-email';
  static const GetUserProfile = '/authen-service/public/v1/user/profile';
  final ApiService apiService;
  AuthService({required this.apiService});
  Future<RegisterUserResponse> registerUser({
    required String email,
    required String password,
    required String name,
    required String language,
    required String timezone,
  }) async {
    final deviceId = await getDeviceId();
    final registerRequest = RegisterRequestModel(email: email,
        password: password,
        name: name,
        language: language,
        timezone: timezone,
        deviceId: deviceId ?? '');
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
          options: Options(
            extra: {'requiresToken': true},
          )
      );
      return LoginUserResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
  Future<OTPResponse> sendOTP({
    required String email,
  }) async {
    final requestBody = OTPRequest(email: email).toJson();
    try {
      final response = await apiService.dio.post(
        SendOTPPath,
        data: requestBody,
      );
      return OTPResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
  Future<OTPResponse> verifyOTP({
    required String email,
    required String otp,
  }) async {
    final requestBody = OTPVerify(email: email, otp: otp).toJson();
    try {
      final response = await apiService.dio.post(
        VerifyOTPPath,
        data: requestBody,
      );
      return OTPResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
  Future<GetUserProfileResponse> getUserProfile(BuildContext context) async {
    try {
      final response = await apiService.dio.get(
        GetUserProfile,
        options: Options(
          extra: {'requiresToken': true},
        )
      );
      return GetUserProfileResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        AuthStorage.clearAuthData();
      }
      //navigate to login screen
      Navigator.pushReplacementNamed(context,AppRoutes.register);
      throw Exception(e);
    }
    catch (e) {
      throw Exception(e);
    }
  }
   Future<void> logout(BuildContext context) async {
    AuthStorage.clearAuthData();
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.register, (route) => false);
  }
}