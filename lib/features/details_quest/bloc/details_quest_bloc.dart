import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questopia/core/repositories/quests/data/quests_repository.dart';
import 'package:questopia/core/repositories/quests/domain/quest_domain.dart';

part 'details_quest_event.dart';

part 'details_quest_state.dart';

class DetailsQuestBloc extends Bloc<DetailsQuestEvent, DetailsQuestState> {
  DetailsQuestBloc({required QuestRepository questRepository})
      : _questRepository = questRepository,
        super(const DetailsQuestInitialState()) {
    on<LoadQuestEvent>(_loadQuest);
  }

  Future<void> _loadQuest(
    LoadQuestEvent event,
    Emitter<DetailsQuestState> emit,
  ) async {
    try {
      if (state is! DetailsQuestLoadedState) {
        emit(const DetailsQuestLoadingState());
      }

      final quest = await _questRepository.getQuest(event.questId);
     emit(DetailsQuestLoadedState(quest: quest));
    } catch (e) {
      emit(DetailsQuestErrorState(error: e));
    }
  }

  final QuestRepository _questRepository;
}
