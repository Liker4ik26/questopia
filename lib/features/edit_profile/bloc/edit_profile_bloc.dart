import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questopia/core/repositories/user/data/user_repository.dart';
import 'package:questopia/core/repositories/user/domain/user_domain.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const EditProfileInitialState()) {
    on<SaveUserEvent>(_saveUser);
  }

  Future<void> _saveUser(
    SaveUserEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    try {
      emit(const EditProfileLoadingState());
      await _userRepository.addUser(
        userDomain: event.user,
      );
      emit(const EditProfileLoadedState());
    } catch (e) {
      emit(EditProfileErrorState(error: e));
    }
  }

  final UserRepository _userRepository;
}
