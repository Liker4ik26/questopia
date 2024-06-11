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
    on<LoadFilterQuestsEvent>(_loadFilteringQuests);
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

  Future<void> _loadFilteringQuests(
    LoadFilterQuestsEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(const HomeLoadingState());

      final questsAll = await _questRepository.getQuests();

      final filterQuests = questsAll.where((quest) {
        final meetsTypes = event.types.isEmpty ||
            event.types.contains(quest.typeOfGame.nameOfType);
        final meetsCategories = event.categories.isEmpty ||
            event.categories
                .any((category) => quest.category.contains(category));
        final meetsPlayerCount = event.countPlayer == null ||
            quest.numberOfPlayerMin <= event.countPlayer! &&
                event.countPlayer! <= quest.numberOfPlayerMax;
        final meetsPriceRange = event.priceStart == null ||
            int.parse(quest.price) >= event.priceStart! &&
                int.parse(quest.price) <= event.priceEnd!;
        final meetsAge =
            event.age.isEmpty || event.age.contains(quest.ageLimit);
        final meetsScaryLevel = event.levelScary.isEmpty ||
            event.levelScary.contains(quest.levelOfFear);
        final meetsDifficultiesLevel = event.levelDifficulties.isEmpty ||
            event.levelDifficulties.contains(quest.difficultyLevel);
        return meetsTypes &&
            meetsCategories &&
            meetsPlayerCount &&
            meetsPriceRange &&
            meetsAge &&
            meetsScaryLevel &&
            meetsDifficultiesLevel;
      }).toList();

      emit(
        HomeLoadedState(quests: filterQuests),
      );
    } catch (e) {
      emit(HomeErrorState(error: e));
    }
  }

  final QuestRepository _questRepository;
}
