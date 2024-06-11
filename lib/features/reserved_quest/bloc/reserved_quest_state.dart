part of 'reserved_quest_bloc.dart';

@immutable
sealed class ReservedQuestState extends Equatable {
  const ReservedQuestState();

  @override
  List<Object?> get props => [];
}

final class ReservedQuestInitialState extends ReservedQuestState {
  const ReservedQuestInitialState();
}

final class ReservedQuestLoadingState extends ReservedQuestState {
  const ReservedQuestLoadingState();
}


final class ReservedQuestLoadedState extends ReservedQuestState {
  const ReservedQuestLoadedState({
    required this.reservedQuests,
  });

  final List<ReservedSlotsQuestDomain> reservedQuests;

  @override
  List<Object?> get props => [reservedQuests];
}

final class ReservedQuestErrorState extends ReservedQuestState {
  const ReservedQuestErrorState({required this.error});

  final Object? error;

  @override
  List<Object?> get props => [error];
}
