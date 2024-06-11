part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class LoadFilterQuestsEvent extends HomeEvent {
  const LoadFilterQuestsEvent(
      {required this.types,
      required this.priceStart,
      required this.priceEnd,
      required this.age,
      required this.levelScary,
      required this.levelDifficulties,
      required this.categories,
      required this.countPlayer});

  final List<String> types;
  final List<String> categories;
  final int? countPlayer;
  final int? priceStart;
  final int? priceEnd;
  final List<int> age;
  final List<int> levelScary;
  final List<int> levelDifficulties;

  @override
  List<Object?> get props => super.props
    ..addAll(types)
    ..addAll(categories)
    ..add(countPlayer);
}

final class LoadQuestsEvent extends HomeEvent {
  const LoadQuestsEvent({
    required this.completer,
    required this.type,
  });

  final Completer? completer;
  final String type;

  @override
  List<Object?> get props => super.props..add(completer);
}
