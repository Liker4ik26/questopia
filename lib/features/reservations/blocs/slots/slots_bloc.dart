import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questopia/core/repositories/slots/data/slots_repository.dart';
import 'package:questopia/core/repositories/slots/domain/slot_domain.dart';

part 'slots_event.dart';

part 'slots_state.dart';

class SlotsBloc extends Bloc<SlotsEvent, SlotsState> {
  SlotsBloc({required SlotsRepository slotsRepository})
      : _slotsRepository = slotsRepository,
        super(const SlotsInitialState()) {
    on<LoadSlotsEvent>(_loadSlotsByQuest);
  }

  Future<void> _loadSlotsByQuest(
    LoadSlotsEvent event,
    Emitter<SlotsState> emit,
  ) async {
    try {
      if (state is! SlotsLoadedState) {
        emit(const SlotsLoadingState());
      }

      final slots = await _slotsRepository.getSlots(event.questId,event.date);
      emit(SlotsLoadedState(slots: slots));
    } catch (e) {
      emit(SlotsErrorState(error: e));
    } finally {
      event.completer?.complete();
    }
  }

  final SlotsRepository _slotsRepository;
}
