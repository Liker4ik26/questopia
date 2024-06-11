part of 'delete_bloc.dart';

@immutable
sealed class DeleteState {
  const DeleteState();
}

final class DeleteInitial extends DeleteState {}

final class DeleteReservedQuestSuccessState extends DeleteState {
  const DeleteReservedQuestSuccessState();
}

final class DeleteReservedQuestLoadingState extends DeleteState {
  const DeleteReservedQuestLoadingState();
}

final class DeleteReservedQuestErrorState extends DeleteState {
  const DeleteReservedQuestErrorState({required this.error});

  final Object? error;
}