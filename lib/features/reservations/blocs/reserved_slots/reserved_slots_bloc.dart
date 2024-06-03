import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questopia/core/repositories/slots/data/slots_repository.dart';
import 'package:questopia/core/repositories/slots/domain/reserved_slot_domain.dart';

part 'reserved_slots_event.dart';

part 'reserved_slots_state.dart';

class ReservedSlotsBloc extends Bloc<ReservedSlotsEvent, ReservedSlotsState> {
  ReservedSlotsBloc({required SlotsRepository slotsRepository})
      : _slotsRepository = slotsRepository,
        super(const ReservedSlotsInitialState()) {
    on<ReservedSlotEvent>(_reservedSlot);
  }

  Future<void> _reservedSlot(
    ReservedSlotEvent event,
    Emitter<ReservedSlotsState> emit,
  ) async {
    try {
      emit(const ReservedSlotsLoadingState());
      await _slotsRepository.reserveSlot(slotDomain: event.reservedSlot);
      emit(const ReservedSlotsLoadedState());
    } catch (e) {
      emit(ReservedSlotsErrorState(error: e));
    }
  }

  final SlotsRepository _slotsRepository;
}
