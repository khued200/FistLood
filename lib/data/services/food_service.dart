import 'package:flutter/cupertino.dart';
import 'package:shopping_conv/data/model/response/get_list_food_response.dart';
import 'package:shopping_conv/data/services/utils/api_instance.dart';
import 'package:dio/dio.dart';
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/utils/auth_storage_util.dart';
class FoodService {
  static final GetAllFoodPath = '/authen-service/public/v1/food';
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
}