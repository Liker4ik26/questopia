part of 'details_quest_bloc.dart';

@immutable
abstract class DetailsQuestEvent {
  const DetailsQuestEvent();
}

final class LoadQuestEvent extends DetailsQuestEvent {
  const LoadQuestEvent({required this.questId});

  final String questId;
}
