class CreateFoodRequest{
  String? name;
  String? type;
  int? unitId;
  int? categoryId;
  String? imageUrl;
  CreateFoodRequest({this.name, this.type, this.unitId, this.categoryId, this.imageUrl});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['unit_id'] = this.unitId;
    data['category_id']  = this.categoryId;
    data['img_url'] = this.imageUrl!.isNotEmpty ? this.imageUrl : null;
    return data;
  }
}