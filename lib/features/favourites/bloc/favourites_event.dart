part of 'favourites_bloc.dart';

@freezed
class FavouritesEvent with _$FavouritesEvent {

  const factory FavouritesEvent.load() = _Load;

  const factory FavouritesEvent.add({
    required QuestEntity entity,
  }) = _Add;

  const factory FavouritesEvent.delete({
    required QuestEntity index,
  }) = _Delete;
}
