part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

final class SearchNewsEvent extends SearchEvent {
  const SearchNewsEvent({
    required this.query,
  });

  final String query;

  @override
  List<Object?> get props => super.props..add(query);
}