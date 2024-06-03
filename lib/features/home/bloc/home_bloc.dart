import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questopia/features/home/home_screen.dart';

import '../../../core/repositories/quests/data/quests_repository.dart';
import '../../../core/repositories/quests/domain/quest_domain.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required QuestRepository questRepository})
      : _questRepository = questRepository,
        super(const HomeInitialState()) {
    on<LoadQuestsEvent>(_loadQuests);
  }

  Future<void> _loadQuests(
    LoadQuestsEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      if (state is! HomeLoadedState) {
        emit(const HomeLoadingState());
      }
      if (event.type == TypeQuest.all.value) {
        emit(const HomeLoadingState());
        final questsAll = await _questRepository.getQuests();
        emit(HomeLoadedState(quests: questsAll));
        return;
      }
      emit(const HomeLoadingState());
      final questsByType = await _questRepository.getType(event.type);
      emit(
        HomeLoadedState(
          quests: questsByType,
        ),
      );
    } catch (e) {
      emit(HomeErrorState(error: e));
    } finally {
      event.completer?.complete();
    }
  }

  final QuestRepository _questRepository;
}
