part of 'filter_bloc.dart';

@immutable
abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object?> get props => [];
}


final class FilterChangedEvent extends FilterEvent {
  const FilterChangedEvent(
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
