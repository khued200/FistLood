import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/data/services/unit_service.dart';
import 'unit_event.dart';
import 'unit_state.dart';

class UnitBloc extends Bloc<UnitEvent, UnitState> {
  final UnitService unitService;

  UnitBloc({required this.unitService}) : super(UnitInitial()) {
    on<FetchUnits>(_onFetchUnits);
  }

  Future<void> _onFetchUnits(FetchUnits event, Emitter<UnitState> emit) async {
    emit(UnitLoading());
    try {
      final response = await unitService.getAllUnit();
      emit(UnitLoaded(response.data));
    } catch (e) {
      emit(UnitError(e.toString()));
    }
  }
}
