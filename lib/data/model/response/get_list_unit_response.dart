class GetListUnitResponse {
  final ListUnitResponse data;
  final String message;
  final int code;

  GetListUnitResponse({required this.data, required this.message, required this.code});

  static Future<GetListUnitResponse> fromJson(Map<String, dynamic> json) async {
    var units = json['data']['units'] != null ? json['data']['units'] as List : [];

    return  GetListUnitResponse(
      data: ListUnitResponse(
        units: units.isNotEmpty ? units.map((e) => UnitResponse(
          id: e['id'],
          name: e['name'],
        )).toList() : [],
        totalItems: json['data']['total_items'],
        totalPages: json['data']['total_pages'],
        currentPage: json['data']['current_page'],
        pageSize: json['data']['page_size'],
        previousPage: json['data']['previous_page'],
        nextPage: json['data']['next_page'],
      ),
      message: json['message'],
      code: json['code'],
    );
  }
}
class ListUnitResponse{
  List<UnitResponse> units;
  int? totalItems;
  int? totalPages;
  int? currentPage;
  int? pageSize;
  int? previousPage;
  int? nextPage;

  ListUnitResponse(
      {required this.units,
        this.totalItems,
        this.totalPages,
        this.currentPage,
        this.pageSize,
        this.previousPage,
        this.nextPage});
}
class UnitResponse{
  int? id;
  String? name;
  UnitResponse({this.id, this.name});
}