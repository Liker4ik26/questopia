part of 'reserved_slots_bloc.dart';

@immutable
abstract class  ReservedSlotsState {
  const  ReservedSlotsState();
}

final class  ReservedSlotsInitialState extends  ReservedSlotsState {
  const  ReservedSlotsInitialState();
}

final class  ReservedSlotsLoadingState extends  ReservedSlotsState {
  const  ReservedSlotsLoadingState();
}

final class  ReservedSlotsLoadedState extends  ReservedSlotsState {
  const  ReservedSlotsLoadedState();
}

final class  ReservedSlotsErrorState extends  ReservedSlotsState {
  const  ReservedSlotsErrorState({required this.error});

  final Object? error;
}