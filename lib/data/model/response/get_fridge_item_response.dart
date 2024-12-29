import 'package:shopping_conv/data/model/response/get_list_food_response.dart';

class GetFridgeItemResponse {
  final String message;
  final List<GetFridgeItemData> data;
  final int code;
  GetFridgeItemResponse({required this.message, required this.data, required this.code});
  static Future<GetFridgeItemResponse> fromJson(data) {
    List<GetFridgeItemData> list = [];
    for (var item in data['data']) {
      var food = item['food'];
      list.add(GetFridgeItemData(
        id: item['id'],
        note: item['note'],
        expiredDate: item['expired_date'],
        quantity: item['quantity'],
        foodId: item['food_id'],
        createdAt: item['created_at'],
        updatedAt: item['updated_at'],
        food: food != null ? FoodData(
          id: food['id'],
          name: food['name'],
          type: food['type'],
          unitID: food['unit_id'],
          categoryId: food['category_id'],
          imgUrl: food['img_url'],
        ) : null,
      ));
    }
    return Future.value(GetFridgeItemResponse(
      message: data['message'],
      data: list,
      code: data['code'],
    ));
  }
}
class GetFridgeItemData {
  int? id;
  String? note;
  int? expiredDate;
  int? quantity;
  int? foodId;
  int? createdAt;
  int? updatedAt;
  FoodData? food;
  GetFridgeItemData({this.id, this.note, this.expiredDate, this.quantity, this.foodId, this.createdAt, this.updatedAt, this.food});
}