import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_conv/models/meal_plan_models.dart';

// Events
abstract class RecipeSearchEvent extends Equatable {
  const RecipeSearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchRecipes extends RecipeSearchEvent {
  final String query;

  const SearchRecipes(this.query);

  @override
  List<Object?> get props => [query];
}

class LoadRecipeCategory extends RecipeSearchEvent {
  final String category;

  const LoadRecipeCategory(this.category);

  @override
  List<Object?> get props => [category];
}

// States
abstract class RecipeSearchState extends Equatable {
  const RecipeSearchState();

  @override
  List<Object?> get props => [];
}

class RecipeSearchInitial extends RecipeSearchState {}

class RecipeSearchLoading extends RecipeSearchState {}

class RecipeSearchLoaded extends RecipeSearchState {
  final List<Recipe> recipes;
  final String category;

  const RecipeSearchLoaded(this.recipes, this.category);

  @override
  List<Object?> get props => [recipes, category];
}

class RecipeSearchError extends RecipeSearchState {
  final String message;

  const RecipeSearchError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class RecipeSearchBloc extends Bloc<RecipeSearchEvent, RecipeSearchState> {
  RecipeSearchBloc() : super(RecipeSearchInitial()) {
    on<SearchRecipes>(_onSearchRecipes);
    on<LoadRecipeCategory>(_onLoadRecipeCategory);
  }

  void _onSearchRecipes(SearchRecipes event, Emitter<RecipeSearchState> emit) async {
    emit(RecipeSearchLoading());
    try {
      // Implement recipe search logic
      final recipes = await _searchRecipes(event.query);
      emit(RecipeSearchLoaded(recipes, 'search_results'));
    } catch (e) {
      emit(RecipeSearchError(e.toString()));
    }
  }

  void _onLoadRecipeCategory(LoadRecipeCategory event, Emitter<RecipeSearchState> emit) async {
    emit(RecipeSearchLoading());
    try {
      final recipes = await _getRecipesByCategory(event.category);
      emit(RecipeSearchLoaded(recipes, event.category));
    } catch (e) {
      emit(RecipeSearchError(e.toString()));
    }
  }

  Future<List<Recipe>> _searchRecipes(String query) async {
    // Implement actual search logic
    return [];
  }

  Future<List<Recipe>> _getRecipesByCategory(String category) async {
    // Implement category filtering logic
    return [];
  }
}