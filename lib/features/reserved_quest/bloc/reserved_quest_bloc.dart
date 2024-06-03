import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questopia/core/repositories/reserved_quest/data/reserved_quest_repository.dart';
import 'package:questopia/core/repositories/reserved_quest/domain/reserved_quest.dart';

part 'reserved_quest_event.dart';

part 'reserved_quest_state.dart';

class ReservedQuestBloc extends Bloc<ReservedQuestEvent, ReservedQuestState> {
  ReservedQuestBloc({required ReservedQuestRepository reservedQuestRepository})
      : _reservedQuestRepository = reservedQuestRepository,
        super(const ReservedQuestInitialState()) {
    on<LoadQuestsEvent>(_loadReservedQuests);
    on<DeleteReservedQuestEvent>(_deleteReservedQuest);
  }

  Future<void> _loadReservedQuests(
    LoadQuestsEvent event,
    Emitter<ReservedQuestState> emit,
  ) async {
    try {
      if (state is! ReservedQuestLoadedState) {
        emit(const ReservedQuestLoadingState());
      }
      emit(const ReservedQuestLoadingState());
      final reservedQuests = await _reservedQuestRepository.getReservedQuests();
      emit(
        ReservedQuestLoadedState(
          reservedQuests: reservedQuests.reversed.toList(),
        ),
      );
    } catch (e) {
      emit(ReservedQuestErrorState(error: e));
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _deleteReservedQuest(
    DeleteReservedQuestEvent event,
    Emitter<ReservedQuestState> emit,
  ) async {
    try {
      emit(const DeleteReservedQuestLoadingState());
      await _reservedQuestRepository.deleteReservedQuest(event.reservedQuest);
      emit(const DeleteReservedQuestSuccessState());
    } catch (e) {
      emit(DeleteReservedQuestErrorState(error: e));
    }
  }

  final ReservedQuestRepository _reservedQuestRepository;
}
