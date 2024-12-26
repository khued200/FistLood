class RegisterRequestModel {
  final String email;
  final String password;
  final String name;
  final String language;
  final String timezone;
  final String deviceId;
  RegisterRequestModel({
    required this.email,
    required this.password,
    required this.name,
    required this.language,
    required this.timezone,
    required this.deviceId,
  });
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'language': language,
      'timezone': timezone,
      'deviceId': deviceId,
    };
  }
}