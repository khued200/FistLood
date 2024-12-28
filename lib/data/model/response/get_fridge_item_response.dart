class GetFridgeItemResponse {
  final String message;
  final List<GetFridgeItemData> data;
  final int code;
  GetFridgeItemResponse({required this.message, required this.data, required this.code});
  static Future<GetFridgeItemResponse> fromJson(data) {
    List<GetFridgeItemData> list = [];
    for (var item in data['data']) {
      list.add(GetFridgeItemData(
        id: item['id'],
        note: item['note'],
        expiredDate: item['expired_date'],
        quantity: item['quantity'],
        foodId: item['food_id'],
        createdAt: item['created_at'],
        updatedAt: item['updated_at'],
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
  GetFridgeItemData({this.id, this.note, this.expiredDate, this.quantity, this.foodId, this.createdAt, this.updatedAt});
}