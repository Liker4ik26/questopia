part of 'reserved_quest_bloc.dart';

@immutable
abstract class ReservedQuestEvent extends Equatable {
  const ReservedQuestEvent();

  @override
  List<Object?> get props => [];
}

final class LoadQuestsEvent extends ReservedQuestEvent {
  const LoadQuestsEvent({
    required this.completer,
  });

  final Completer? completer;

  @override
  List<Object?> get props => super.props..add(completer);
}

final class DeleteReservedQuestEvent extends ReservedQuestEvent {
  const DeleteReservedQuestEvent({
    required this.reservedQuest,
  });

  final ReservedSlotsQuestDomain reservedQuest;
}
