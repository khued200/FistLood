class CreateFridgeItemRequest{
  int foodId;
  int quantity;
  int expiredDate;
  String? note;
  CreateFridgeItemRequest({
    required this.foodId,
    required this.quantity,
    required this.expiredDate,
    this.note,
  });
  Map<String, dynamic> toJson() {
    return {
      'food_id': foodId,
      'quantity': quantity,
      'expired_date': expiredDate,
      'note': note,
    };
  }
}