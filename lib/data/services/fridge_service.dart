import 'package:flutter/cupertino.dart';
import 'package:shopping_conv/data/model/request/create_fridge_item_request.dart';
import 'package:shopping_conv/data/model/response/create_fridge_item_response.dart';
import 'package:shopping_conv/data/model/response/get_fridge_item_response.dart';
import 'package:shopping_conv/data/services/utils/api_instance.dart';
import 'package:dio/dio.dart';
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/utils/auth_storage_util.dart';
class FridgeService {
  static const GetFridgeItem = '/authen-service/public/v1/fridge';
  static const CreateFridgeItem = '/authen-service/public/v1/fridge';
  final ApiService apiService;
  FridgeService({required this.apiService});
  Future<GetFridgeItemResponse> getFridgeItem(BuildContext context) async {
    try {
      final response = await apiService.dio.get(
        GetFridgeItem,
        options: Options(
          extra: {'requiresToken': true},
        )
      );
      return GetFridgeItemResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        AuthStorage.clearAuthData();
      }
      //navigate to login screen
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.register, (route) => false);
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
  Future<CreateFridgeItemResponse> addFridgeItem(BuildContext context,int foodId, int quantity, int expiredDate, String? note) async {
    try {
      var requestBody = CreateFridgeItemRequest(foodId: foodId, quantity: quantity, expiredDate: expiredDate, note: note).toJson();
      final response = await apiService.dio.post(
        GetFridgeItem,
        data: requestBody,
        options: Options(
          extra: {'requiresToken': true},
        )
      );
      return CreateFridgeItemResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        AuthStorage.clearAuthData();
      }
      //navigate to login screen
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.register, (route) => false);
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}