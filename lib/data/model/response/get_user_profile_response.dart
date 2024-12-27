class GetUserProfileResponse {
  final int code;
  final String message;
  final GetUserProfileData data;
  GetUserProfileResponse({
    required this.code,
    required this.message,
    required this.data,
  });
  static Future<GetUserProfileResponse> fromJson(data) {
    return Future.value(GetUserProfileResponse(
      code: data['code'],
      message: data['message'],
      data: GetUserProfileData(
        id: data['data']['id'],
        userId: data['data']['user_id'],
        name: data['data']['name'],
        email: data['data']['email'],
        avatarImageUrl: data['data']['avatar_image_url'],
      ),
    ));
  }
}
class GetUserProfileData {
  int? id;
  int? userId;
  String? name;
  String? email;
  String? avatarImageUrl;
  GetUserProfileData({this.id, this.userId, this.name, this.email, this.avatarImageUrl});
}