import 'package:shopping_conv/data/model/response/get_list_category_response.dart';
import 'package:shopping_conv/data/model/response/get_list_food_response.dart';
import 'package:shopping_conv/data/model/response/get_list_unit_response.dart';

class GetFoodDetailResponse {
  final int code;
  final String message;
  final FoodDetailData data;
  GetFoodDetailResponse({required this.code, required this.message, required this.data});
  static Future<GetFoodDetailResponse> fromJson(Map<String, dynamic> json) async {
    return GetFoodDetailResponse(
      code: json['code'],
      message: json['message'],
      data: FoodDetailData(
        id: json['data']['id'],
        name: json['data']['name'],
        type: json['data']['type'],
        unitId: json['data']['unit_id'],
        categoryId: json['data']['category_id'],
        imageUrl: json['data']['img_url'],
        unit: UnitResponse(
          id: json['data']['unit']['id'],
          name: json['data']['unit']['name'],
        ),
        category: json['data']['category'] != null ? CategoryResponse(
          id: json['data']['category']['id'],
          name: json['data']['category']['name'],
        ) : null
    ));
  }

}
class FoodDetailData extends FoodData{
  CategoryResponse? category;
  UnitResponse unit;
  FoodDetailData({
    required int id,
    required String name,
    required String type,
    required int unitId,
    required int categoryId,
    required String imageUrl,
    this.category,
    required this.unit,
  }) : super(
    id: id,
    name: name,
    type: type,
    unitID: unitId,
    categoryId: categoryId,
    imgUrl: imageUrl,
  );
}