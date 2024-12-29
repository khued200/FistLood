import 'package:shopping_conv/data/model/response/get_list_category_response.dart';
import 'package:shopping_conv/data/services/utils/api_instance.dart';
import 'package:dio/dio.dart';
class CategoryService {
  static const GetAllCategoryPath = '/authen-service/public/v1/food/category';
  final ApiService apiService;
  CategoryService({required this.apiService});
   Future<GetListCategoryResponse> getAllCategory() async {
    try{
      final response = await apiService.dio.get(
        GetAllCategoryPath,
        options: Options(
          extra: {'requiresToken': true},
        )
      );
      return GetListCategoryResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}