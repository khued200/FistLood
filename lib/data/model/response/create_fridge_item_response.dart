class CreateFridgeItemResponse {
  final int code;
  final String message;
  final CreateFridgeItemData data;
  CreateFridgeItemResponse({required this.code, required this.message, required this.data});
  static Future<CreateFridgeItemResponse> fromJson(data) {
    return Future.value(CreateFridgeItemResponse(
      code: data['code'],
      message: data['message'],
      data: CreateFridgeItemData(
        id: data['data']['id'],
        note: data['data']['note'],
        expiredDate: data['data']['expired_date'],
        quantity: data['data']['quantity'],
        foodId: data['data']['food_id'],
      ),
    ));
  }
}
class CreateFridgeItemData{
  int? id;
  String? note;
  int? expiredDate;
  int? quantity;
  int? foodId;
  CreateFridgeItemData({this.id, this.note, this.expiredDate, this.quantity, this.foodId});
}