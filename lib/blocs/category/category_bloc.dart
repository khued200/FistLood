import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/blocs/category/catgory_event.dart';
import 'package:shopping_conv/data/services/category_service.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryService categoryService;

  CategoryBloc({required this.categoryService}) : super(CategoryInitial()) {
    on<FetchCategories>(_onFetchCategories);
  }

  Future<void> _onFetchCategories(
      FetchCategories event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      final response = await categoryService.getAllCategory();
      emit(CategoryLoaded(response.data));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
