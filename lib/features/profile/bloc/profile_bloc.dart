import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questopia/core/repositories/user/data/user_repository.dart';
import 'package:questopia/core/repositories/user/domain/user_domain.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const ProfileInitialState()) {
    on<LoadUserEvent>(_loadUser);
    on<LogOutEvent>(_logOut);
  }

  Future<void> _loadUser(
      LoadUserEvent event, Emitter<ProfileState> emit) async {
    try {
      if (state is! ProfileLoadedState) {
        emit(const ProfileLoadingState());
      }

      final UserDomain user = await _userRepository.getUserById();
      emit(
        ProfileLoadedState(user: user),
      );
    } catch (e) {
      emit(ProfileErrorState(error: e));
    }
  }

  Future<void> _logOut(LogOutEvent event, Emitter<ProfileState> emit) async {
    try {
      if (state is! LogOutSuccessState) {
        emit(const LogOutLoadingState());
      }

      await _userRepository.signOut();
      emit(const LogOutSuccessState());
    } catch (e) {
      emit(LogOutErrorState(error: e));
    }
  }

  final UserRepository _userRepository;
}
