import 'package:flutter/cupertino.dart';

class RegisterUserResponse {
  final int code;
  final String message;
  final RegisterUserResponseData data;
  RegisterUserResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  static Future<RegisterUserResponse> fromJson(data) {
    return Future.value(RegisterUserResponse(
      code: data['code'],
      message: data['message'],
      data: RegisterUserResponseData(
        id: data['data']['id'],
        email: data['data']['email'],
        isVerified: data['data']['is_verified'],
        isActive: data['data']['is_active'],
      ),
    ));
  }

}
class RegisterUserResponseData {
  int id;
  String email;
  bool isVerified;
  bool isActive;
  RegisterUserResponseData({
    required this.id,
    required this.email,
    required this.isVerified,
    required this.isActive,
  });

}