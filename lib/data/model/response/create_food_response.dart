class CreateFoodResponse{
  final int code;
  final String message;
  final CreateFoodData data;
  CreateFoodResponse({required this.code, required this.message, required this.data});
  static Future<CreateFoodResponse> fromJson(Map<String, dynamic> json) async {
    return CreateFoodResponse(
      code: json['code'],
      message: json['message'],
      data: CreateFoodData(
        id: json['data']['id'],
        name: json['data']['name'],
        type: json['data']['type'],
        unitId: json['data']['unit_id'],
        categoryId: json['data']['category_id']));
  }
}
class CreateFoodData{
  int? id;
  String? name;
  String? type;
  int? unitId;
  int? categoryId;
  CreateFoodData({this.id, this.name, this.type, this.unitId, this.categoryId});
}