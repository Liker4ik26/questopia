part of 'slots_bloc.dart';

@immutable
sealed class  SlotsState extends Equatable {
  const  SlotsState();

  @override
  List<Object?> get props => [];
}

final class  SlotsInitialState extends  SlotsState {
  const  SlotsInitialState();
}

final class  SlotsLoadingState extends  SlotsState {
  const  SlotsLoadingState();
}

final class  SlotsLoadedState extends  SlotsState {
  const  SlotsLoadedState({
    required this. slots,
  });

  final List<SlotDomain>  slots;

  @override
  List<Object?> get props => [ slots];
}

final class  SlotsErrorState extends  SlotsState {
  const  SlotsErrorState({required this.error});

  final Object? error;

  @override
  List<Object?> get props => [error];
}
