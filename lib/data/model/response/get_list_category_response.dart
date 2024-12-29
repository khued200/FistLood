class GetListCategoryResponse {
  final int code;
  final String message;
  final ListCategoryResponse data;
  GetListCategoryResponse({required this.code, required this.message, required this.data});
  static Future<GetListCategoryResponse> fromJson(Map<String, dynamic> json) async {
    var categories = json['data']['categories'] != null ?  json['data']['categories'] as List : [];
    return GetListCategoryResponse(
      code: json['code'],
      message: json['message'],
      data: ListCategoryResponse(
        categories: categories.isNotEmpty ? categories.map((e) => CategoryResponse(
          id: e['id'],
          name: e['name'],
        )).toList() : [],
        totalItems: json['data.total_items'],
        totalPages: json['data.total_pages'],
        currentPage: json['data.current_page'],
        pageSize: json['data.page_size'],
        previousPage: json['data.previous_page'],
        nextPage: json['data.next_page'],
      ),
    );
  }
}
class ListCategoryResponse{
  List<CategoryResponse> categories;
  int? totalItems;
  int? totalPages;
  int? currentPage;
  int? pageSize;
  int? previousPage;
  int? nextPage;

  ListCategoryResponse(
      {required this.categories,
      this.totalItems,
      this.totalPages,
      this.currentPage,
      this.pageSize,
      this.previousPage,
      this.nextPage});
}
class CategoryResponse {
   int? id;
   String? name;

  CategoryResponse(
      {this.id,
      this.name});
}