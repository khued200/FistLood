class GetListMealResponse{
  final int code;
  final String message;
  final List<MealResponse> data;
  GetListMealResponse({required this.code, required this.message, required this.data});
  static Future<GetListMealResponse> fromJson(Map<String, dynamic> json) async{
    List<MealResponse> listMealResponse = [];
    for(var item in json['data']){
      listMealResponse.add(MealResponse(
        id: item['id'],
        name: item['name'],
        description: item['description'],
        schedule: item['schedule'],
        status: item['status'],
        foodIds: item['foodIds']
      ));
    }
    return GetListMealResponse(
      code: json['code'],
      message: json['message'],
      data: listMealResponse
    );
  }
}
class MealResponse{
  int? id;
  String? name;
  String? description;
  int? schedule;
  String? status;
  List<int>? foodIds;
  MealResponse({this.id, this.name, this.description, this.schedule, this.status, this.foodIds});
  static MealResponse fromJson(Map<String, dynamic> json){
    return MealResponse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      schedule: json['schedule'],
      status: json['status'],
      foodIds: json['foodIds']
    );
  }
}