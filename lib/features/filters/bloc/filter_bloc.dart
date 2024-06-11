import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filter_event.dart';

part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterState.initial()) {
    on<FilterChangedEvent>(_loadFilterChanged);
  }

  Future<void> _loadFilterChanged(
    FilterChangedEvent event,
    Emitter<FilterState> emit,
  ) async {
    emit(
      state.copyWith(
        types: event.types,
        categories: event.categories,
        countPlayer: event.countPlayer,
        priceStart: event.priceStart,
        priceEnd: event.priceEnd,
        age: event.age,
        levelScary: event.levelScary,
        levelDifficulties: event.levelDifficulties,
      ),
    );
  }
}
