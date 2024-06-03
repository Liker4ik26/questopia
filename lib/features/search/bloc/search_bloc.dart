import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questopia/core/repositories/quests/domain/quest_domain.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/repositories/quests/data/quests_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required QuestRepository questRepository})
      : _questRepository = questRepository,
        super(const SearchInitialState()) {
    on<SearchNewsEvent>(
      _searchNews,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 800))
            .asyncExpand(mapper);
      },
    );
  }

  Future<void> _searchNews(
    SearchNewsEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(const SearchInitialState());
      return;
    }

    try {
      emit(const SearchLoadingState());

      final quests = await _questRepository.searchByName(
        query: event.query,
      );

      emit(SearchLoadedState(quests: quests));
    } catch (e) {
      emit(SearchErrorState(error: e));
    }
  }

  final QuestRepository _questRepository;
}
