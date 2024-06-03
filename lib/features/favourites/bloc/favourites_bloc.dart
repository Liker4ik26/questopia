import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:questopia/core/database/model/quest_entity.dart';

import '../../../core/repositories/local_database/data/local_database_repository_impl.dart';

part 'favourites_bloc.freezed.dart';

part 'favourites_event.dart';

part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc({
    required LocalDatabaseRepository localDatabaseRepository,
  })  : _localDatabaseRepository = localDatabaseRepository,
        super(const FavouritesState.initial()) {
    on<FavouritesEvent>((events, emit) async {
      await events.map(
        load: (event) => _loadItems(event, emit),
        add: (event) => _add(event, emit),
        delete: (event) => _delete(event, emit),
      );
    });
  }

  Future<void> _loadItems(
    _Load event,
    Emitter<FavouritesState> emit,
  ) async {
    final items = _localDatabaseRepository.loadQuests();
    emit(
      FavouritesState.loaded(
        items: items,
      ),
    );
  }

  Future<void> _add(
    _Add event,
    Emitter<FavouritesState> emit,
  ) async {
    await _localDatabaseRepository.addQuest(entity: event.entity);
    emit(FavouritesState.loaded(items: _localDatabaseRepository.loadQuests()));
  }

  Future<void> _delete(
    _Delete event,
    Emitter<FavouritesState> emit,
  ) async {
    await _localDatabaseRepository.deleteQuest(questId: event.index.questId);
    emit(FavouritesState.loaded(items: _localDatabaseRepository.loadQuests()));
  }

  final LocalDatabaseRepository _localDatabaseRepository;
}
