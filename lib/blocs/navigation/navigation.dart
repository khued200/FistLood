import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/ui/helper_func.dart';

// Events
abstract class NavigationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigateToTab extends NavigationEvent {
  final int tabIndex;

  NavigateToTab(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}

// States
class NavigationState extends Equatable {
  final int currentIndex;

  const NavigationState({this.currentIndex = 0});

  NavigationState copyWith({
    int? currentIndex,
  }) {
    return NavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object> get props => [currentIndex];
}

// BLoC
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState()) {
    on<NavigateToTab>(_onNavigateToTab);
  }

  void _onNavigateToTab(NavigateToTab event, Emitter<NavigationState> emit) {
    emit(state.copyWith(currentIndex: event.tabIndex));
  }
}

// lib/widgets/custom_bottom_navigation.dart
class CustomBottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            if (state.currentIndex != index) {
              // Update the navigation state
              context.read<NavigationBloc>().add(NavigateToTab(index));

              // Navigate to the new route
              Navigator.pushNamed(
                context,
                getRouteFromIndex(index),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Lists"),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "Recipes"),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), label: "Meal Plan"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ],
        );
      },
    );
  }
}