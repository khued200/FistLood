import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_conv/ui/list/widgets/grocery_item_list.dart';
import '../grocery/grocery_list_event.dart';
import '../grocery/grocery_list_state.dart';

class GroceryBloc extends Bloc<GroceryEvent, GroceryState> {
  GroceryBloc() : super(const GroceryState(groceryLists: [])) {
    on<AddGroceryItem>(_onAddGroceryItem);
    on<ToggleAddItemMode>(_onToggleAddItemMode);
    on<EditGroceryItem>(_onEditGroceryItem);
    on<DeleteGroceryItem>(_onDeleteGroceryItem);
  }

  void _onAddGroceryItem(AddGroceryItem event, Emitter<GroceryState> emit) {
    try {
      final currentLists = List<GroceryList>.from(state.groceryLists);

      // Find existing category or create new one
      var categoryList = currentLists.firstWhere(
        (list) => list.category == event.category,
        orElse: () {
          final newList = GroceryList(
            category: event.category,
            grocerylist: [],
          );
          currentLists.add(newList);
          return newList;
        },
      );

      // Add new item
      categoryList.grocerylist.add(GroceryItem(
        item: event.item,
        quantity: event.quantity,
      ));
      
      emit(state.copyWith(
        groceryLists: currentLists,
        isAddingItem: false,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void _onToggleAddItemMode(ToggleAddItemMode event, Emitter<GroceryState> emit) {
    emit(state.copyWith(isAddingItem: event.isAdding));
  }

  void _onEditGroceryItem(EditGroceryItem event, Emitter<GroceryState> emit) {
    try {
      final currentLists = List<GroceryList>.from(state.groceryLists);

      // Xóa mục khỏi danh mục cũ
      var oldCategoryList = currentLists.firstWhere(
        (list) => list.category == event.oldCategory,
        orElse: () => throw Exception('Category not found'),
      );

      // Tạo danh sách mới không chứa mục cũ
      var updatedItems = oldCategoryList.grocerylist
          .where((item) => item.item != event.oldItem)
          .toList();

      // Xóa danh mục cũ nếu trống
      if (updatedItems.isEmpty) {
        currentLists.removeWhere((list) => list.category == event.oldCategory);
      } else {
        var oldCategoryIndex = currentLists.indexWhere(
          (list) => list.category == event.oldCategory,
        );
        currentLists[oldCategoryIndex] = GroceryList(
          category: event.oldCategory,
          grocerylist: updatedItems,
        );
      }

      // Xác định danh mục mới dựa trên `newItem`
      final mappedCategory = getCategoryFromItem(event.newItem, groceryCategories);

      // Thêm mục vào danh mục mới
      var newCategoryList = currentLists.firstWhere(
        (list) => list.category == mappedCategory,
        orElse: () {
          var newList = GroceryList(
            category: mappedCategory,
            grocerylist: [],
          );
          currentLists.add(newList);
          return newList;
        },
      );

      // Thêm mục mới vào danh mục mới
      var newCategoryIndex = currentLists.indexWhere(
        (list) => list.category == mappedCategory,
      );

      var newItems = List<GroceryItem>.from(currentLists[newCategoryIndex].grocerylist);
      newItems.add(GroceryItem(
        item: event.newItem,
        quantity: event.newQuantity,
      ));

      currentLists[newCategoryIndex] = GroceryList(
        category: mappedCategory,
        grocerylist: newItems,
      );

      // Cập nhật trạng thái
      emit(state.copyWith(groceryLists: currentLists));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void _onDeleteGroceryItem(DeleteGroceryItem event, Emitter<GroceryState> emit) {
    try {
      final currentLists = List<GroceryList>.from(state.groceryLists);
      
      var categoryList = currentLists.firstWhere(
        (list) => list.category == event.category,
        orElse: () => throw Exception('Category not found'),
      );
      
      // Create new list without the deleted item
      var updatedItems = categoryList.grocerylist
          .where((item) => item.item != event.item)
          .toList();
      
      // Remove the category if it's empty, otherwise update it
      if (updatedItems.isEmpty) {
        currentLists.removeWhere((list) => list.category == event.category);
      } else {
        var categoryIndex = currentLists.indexWhere(
          (list) => list.category == event.category,
        );
        currentLists[categoryIndex] = GroceryList(
          category: event.category,
          grocerylist: updatedItems,
        );
      }
      
      emit(state.copyWith(groceryLists: currentLists));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}