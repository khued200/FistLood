class GetListFoodResponse {
  final int code;
  final String message;
  final List<FoodData> data;
  GetListFoodResponse({required this.code, required this.message, required this.data});
  static Future<GetListFoodResponse> fromJson(Map<String, dynamic> json) async {
    var foods = json['data.foods'] != null ?  json['data.foods'] as List : [];
    return GetListFoodResponse(
      code: json['code'],
      message: json['message'],
      data: foods.isNotEmpty  ? foods.map((e) => FoodData(
        id: e['id'],
        name: e['name'],
        type: e['type'],
        imgUrl: e['img_url'],
        categoryId: e['category_id'],
        unitID: e['unit_id'],
      )).toList() : [],
    );
  }

}
class FoodData{
  int? id;
  String? name;
  String? type;
  String? imgUrl;
  int? categoryId;
  int? unitID;
  FoodData({this.id, this.name, this.type, this.imgUrl, this.categoryId, this.unitID});
}