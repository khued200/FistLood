import 'package:shopping_conv/data/model/response/get_list_unit_response.dart';
import 'package:shopping_conv/data/services/utils/api_instance.dart';
import 'package:dio/dio.dart';
class UnitService{
  static const String GetAllUnitsPath = '/authen-service/public/v1/food/unit';
  final ApiService apiService;
  UnitService({required this.apiService});
  Future<GetListUnitResponse> getAllUnit() async {
    try{
      final response = await apiService.dio.get(
        GetAllUnitsPath,
        options: Options(
          extra: {'requiresToken': true},
        )
      );
      return GetListUnitResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}