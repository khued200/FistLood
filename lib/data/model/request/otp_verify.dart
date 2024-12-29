class OTPVerify {
  String email;
  String otp;
  OTPVerify({required this.email, required this.otp});
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
    };
  }
}