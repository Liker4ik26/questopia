part of 'filter_bloc.dart';

class FilterState extends Equatable {
  final List<String> types;
  final List<String> categories;
  final int? countPlayer;
  final int? priceStart;
  final int? priceEnd;
  final List<int> age;
  final List<int> levelScary;
  final List<int> levelDifficulties;

  const FilterState({
    required this.types,
    required this.categories,
    required this.countPlayer,
    required this.priceStart,
    required this.priceEnd,
    required this.age,
    required this.levelScary,
    required this.levelDifficulties,
  });

  factory FilterState.initial() {
    return FilterState(
        types: [],
        categories: [],
        countPlayer: 2,
        priceStart: 2000,
        priceEnd: 10000,
        age: [],
        levelScary: [],
        levelDifficulties: []);
  }

  FilterState copyWith({
    List<String>? types,
    List<String>? categories,
    int? countPlayer,
    int? priceStart,
    int? priceEnd,
    List<int>? age,
    List<int>? levelScary,
    List<int>? levelDifficulties,
  }) {
    return FilterState(
      types: types ?? this.types,
      categories: categories ?? this.categories,
      countPlayer: countPlayer ?? this.countPlayer,
      priceStart: priceStart ?? this.priceStart,
      priceEnd: priceEnd ?? this.priceEnd,
      age: age ?? this.age,
      levelScary: levelScary ?? this.levelScary,
      levelDifficulties: levelDifficulties ?? this.levelDifficulties,
    );
  }

  @override
  List<Object?> get props => [
        types,
        categories,
        countPlayer,
        priceStart,
        priceEnd,
        age,
        levelScary,
        levelDifficulties,
      ];

  @override
  bool get stringify => true;
}
