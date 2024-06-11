part of 'delete_bloc.dart';

@immutable
abstract class DeleteEvent {
  const DeleteEvent();
}

final class DeleteReservedQuestEvent extends DeleteEvent {
  const DeleteReservedQuestEvent({
    required this.reservedQuest,
  });

  final ReservedSlotsQuestDomain reservedQuest;
}
