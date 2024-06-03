part of 'favourites_bloc.dart';

@freezed
class FavouritesState with _$FavouritesState {
  const factory FavouritesState.initial() = _Initial;

  const factory FavouritesState.loaded({
    required List<QuestEntity> items,
  }) = _Loaded;
}
