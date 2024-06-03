part of 'slots_bloc.dart';

@immutable
abstract class SlotsEvent extends Equatable {
  const SlotsEvent();

  @override
  List<Object?> get props => [];
}

final class LoadSlotsEvent extends SlotsEvent {
  const LoadSlotsEvent({
    required this.completer,
    required this.questId,
    required this.date,
  });

  final Completer? completer;
  final String questId;
  final DateTime date;

  @override
  List<Object?> get props => super.props..add(completer);
}
