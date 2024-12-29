class CreateMealRequest {
  String name;
  String? description;
  int scheduledDate;
  String status;
  List<int>? foodIds;
  CreateMealRequest({
    required this.name,
    this.description,
    required this.scheduledDate,
    required this.status,
    this.foodIds,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (description != null) {
      data['description'] = description;
    }
    data['schedule'] = scheduledDate;
    data['status'] = status;
    if (foodIds != null) {
      data['foodIds'] = foodIds;
    }
    return data;
  }
}
