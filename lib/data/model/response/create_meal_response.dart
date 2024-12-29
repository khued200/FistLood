import 'package:shopping_conv/data/model/response/get_list_meal_response.dart';

class CreateMealResponse{
  final int code;
  final String message;
  final MealResponse data;
  CreateMealResponse({
    required this.code,
    required this.message,
    required this.data,
  });
  static CreateMealResponse fromJson(Map<String, dynamic> json) {
    return CreateMealResponse(
      code: json['code'] as int,
      message: json['message'] as String,
      data: MealResponse.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}