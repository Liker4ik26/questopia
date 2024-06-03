part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
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

