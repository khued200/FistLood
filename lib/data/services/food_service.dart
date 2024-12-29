import 'package:flutter/cupertino.dart';
import 'package:shopping_conv/data/model/request/create_food_request.dart';
import 'package:shopping_conv/data/model/response/create_food_response.dart';
import 'package:shopping_conv/data/model/response/get_food_detail_response.dart';
import 'package:shopping_conv/data/model/response/get_list_food_response.dart';
import 'package:shopping_conv/data/services/utils/api_instance.dart';
import 'package:dio/dio.dart';
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/utils/auth_storage_util.dart';
class FoodService {
  static final GetAllFoodPath = '/authen-service/public/v1/food';
  static final CreateFoodPath = '/authen-service/public/v1/food';
  static final GetDetailFoodPath = '/authen-service/public/v1/food/';
  final ApiService apiService;
  FoodService({required this.apiService});
  Future<GetListFoodResponse> getAllFood(BuildContext context) async{
    try{
      final response = await apiService.dio.get(
        GetAllFoodPath,
        options: Options(
          extra: {'requiresToken': true},
        )
      );
      return GetListFoodResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        AuthStorage.clearAuthData();
      }
      //navigate to login screen
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.register, (route) => false);
      throw Exception(e);
    }catch (e){
      throw Exception(e);
    }
  }
  Future<CreateFoodResponse> createFood(BuildContext context, {
    required String name,
    required String type,
    int? categoryId,
    required int unitId,
    String? imageUrl,
  }) async {
    try {
      var requestBody = CreateFoodRequest(
        name: name,
        type: type,
        categoryId: categoryId,
        unitId: unitId,
        imageUrl: imageUrl,
      ).toJson();
      final response = await apiService.dio.post(
        CreateFoodPath,
        data: requestBody,
        options: Options(
          extra: {'requiresToken': true},
        ),
      );
      return CreateFoodResponse.fromJson(response.data);
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
  Future<GetFoodDetailResponse> getFoodDetail(BuildContext context, int id) async {
    try {
      final response = await apiService.dio.get(
        GetDetailFoodPath + id.toString(),
        options: Options(
          extra: {'requiresToken': true},
        ),
      );
      return GetFoodDetailResponse.fromJson(response.data);
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