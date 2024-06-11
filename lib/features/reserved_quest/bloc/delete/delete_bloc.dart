import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:questopia/core/repositories/reserved_quest/data/reserved_quest_repository.dart';
import 'package:questopia/core/repositories/reserved_quest/domain/reserved_quest.dart';

part 'delete_event.dart';

part 'delete_state.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  DeleteBloc({required ReservedQuestRepository reservedQuestRepository})
      : _reservedQuestRepository = reservedQuestRepository,
        super(DeleteInitial()) {
    on<DeleteReservedQuestEvent>(_deleteReservedQuest);
  }

  Future<void> _deleteReservedQuest(
    DeleteReservedQuestEvent event,
    Emitter<DeleteState> emit,
  ) async {
    try {
      emit(const DeleteReservedQuestLoadingState());
      await _reservedQuestRepository.deleteReservedQuest(event.reservedQuest);
      emit(const DeleteReservedQuestSuccessState());
    } catch (e) {
      emit(DeleteReservedQuestErrorState(error: e));
    }
  }

  final ReservedQuestRepository _reservedQuestRepository;
}
