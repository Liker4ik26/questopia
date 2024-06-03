import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questopia/core/repositories/auth/data/auth_repository.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const SignInInitialState()) {
    on<LogInEvent>(_signIn);
  }

  Future<void> _signIn(
    LogInEvent event,
    Emitter<SignInState> emit,
  ) async {
    try {
      emit(const SignInLoadingState());
      await _authRepository.signIn(
          email: event.email, password: event.password);
      emit(const SignInLoadedState());
    } catch (e) {
      emit(SignInErrorState(error: e));
    }
  }

  final AuthRepository _authRepository;
}
