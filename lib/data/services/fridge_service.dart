import 'package:shopping_conv/data/model/response/get_fridge_item_response.dart';
import 'package:shopping_conv/data/services/utils/api_instance.dart';
import 'package:dio/dio.dart';
class FridgeService {
  static const GetFridgeItem = '/authen-service/public/v1/fridge';
  final ApiService apiService;
  FridgeService({required this.apiService});
  Future<GetFridgeItemResponse> getFridgeItem() async {
    try {
      final response = await apiService.dio.get(
        GetFridgeItem,
        options: Options(
          extra: {'requiresToken': true},
        )
      );
      return GetFridgeItemResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}