part of 'details_quest_bloc.dart';

sealed class DetailsQuestState {
  const DetailsQuestState();

}

final class DetailsQuestInitialState extends DetailsQuestState {
  const DetailsQuestInitialState();
}

final class DetailsQuestLoadingState extends DetailsQuestState {
  const DetailsQuestLoadingState();
}

final class DetailsQuestLoadedState extends DetailsQuestState {
   DetailsQuestLoadedState({required this.quest});

 QuestDomain quest;

}

final class DetailsQuestErrorState extends DetailsQuestState {
  const DetailsQuestErrorState({required this.error});

  final Object? error;

}
