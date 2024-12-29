import 'package:flutter/cupertino.dart';
import 'package:shopping_conv/data/model/request/create_meal_request.dart';
import 'package:shopping_conv/data/model/response/create_meal_response.dart';
import 'package:shopping_conv/data/model/response/get_list_meal_response.dart';
import 'package:shopping_conv/data/services/utils/api_instance.dart';
import 'package:dio/dio.dart';
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/utils/auth_storage_util.dart';

class MealService{
  static const String GetListMealPath = '/authen-service/public/v1/meal-plan';
  final ApiService apiService;
  MealService({required this.apiService});
  Future<GetListMealResponse> getListMeal(BuildContext context, int? date) async {
    try{
      var path = date != null ? '$GetListMealPath?date=$date' : '$GetListMealPath?date=${DateTime.now().millisecondsSinceEpoch}';
      final response = await apiService.dio.get(
        path,
        options: Options(
          extra: {'requiresToken': true},
        )
      );
      return GetListMealResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        AuthStorage.clearAuthData();
        //navigate to login screen
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.register, (route) => false);
      }
      throw Exception(e);
    }
    catch (e) {
      throw Exception(e);
    }
  }
  Future<CreateMealResponse> createMeal(BuildContext context, String name, String description, int schedule, String status, List<int> foodIds) async {
    try{
      var requestBody = CreateMealRequest(name: name, scheduledDate: schedule, status: status, description: description, foodIds: foodIds);
      final response = await apiService.dio.post(
        GetListMealPath,
        data: requestBody,
        options: Options(
          extra: {'requiresToken': true},
        )
      );
      return CreateMealResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        AuthStorage.clearAuthData();
        //navigate to login screen
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.register, (route) => false);
      }
      throw Exception(e);
    }
    catch (e) {
      throw Exception(e);
    }
  }
}