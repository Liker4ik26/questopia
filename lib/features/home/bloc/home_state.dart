part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitialState extends HomeState {
  const HomeInitialState();
}

final class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}

final class HomeLoadedState extends HomeState {
  const HomeLoadedState({
    required this.quests,
  });

  final List<QuestDomain> quests;

  @override
  List<Object?> get props => [quests];
}

final class HomeErrorState extends HomeState {
  const HomeErrorState({required this.error});

  final Object? error;

  @override
  List<Object?> get props => [error];
}
