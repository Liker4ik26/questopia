part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

final class SearchInitialState extends SearchState {
  const SearchInitialState();
}

final class SearchLoadingState extends SearchState {
  const SearchLoadingState();
}

final class SearchLoadedState extends SearchState {
  const SearchLoadedState({
    required this.quests,
  });

  final List<QuestDomain> quests;
}

final class SearchErrorState extends SearchState {
  const SearchErrorState({
    required this.error,
  });

  final Object? error;
}
