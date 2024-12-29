class OTPRequest {
  String email;
  OTPRequest({required this.email});
  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}