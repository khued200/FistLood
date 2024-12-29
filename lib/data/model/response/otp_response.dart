class OTPResponse {
  final String message;
  final int code;
  OTPResponse({
    required this.message,
    required this.code,
  });
  static Future<OTPResponse> fromJson(data) {
    return Future.value(OTPResponse(
      message: data['message'],
      code: data['code'],
    ));
  }
}