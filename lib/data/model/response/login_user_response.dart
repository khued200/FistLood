class LoginUserResponse {
  final int code;
  final String message;
  final LoginUserData data;
  LoginUserResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  static Future<LoginUserResponse> fromJson(data) {
    return Future.value(LoginUserResponse(
      code: data['code'],
      message: data['message'],
      data: LoginUserData(
        accessToken: data['data']['access_token'],
        refreshToken: data['data']['refresh_token'],
        isVerified: data['data']['is_verified'],
      ),
    ));
  }

}
class LoginUserData {
  final String accessToken;
  final String refreshToken;
  final bool isVerified;
  LoginUserData({
    required this.accessToken,
    required this.refreshToken,
    required this.isVerified,
  });
}