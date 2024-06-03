import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questopia/core/repositories/auth/data/auth_repository.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const SignUpInitialState()) {
    on<RegistrationEvent>(
      _signUp,
    );
  }

  Future<void> _signUp(
    RegistrationEvent event,
    Emitter<SignUpState> emit,
  ) async {
    try {
      emit(const SignUpLoadingState());
      await _authRepository.signUp(
        email: event.email,
        password: event.password,
      );
      emit(const SignUpLoadedState());
    } catch (e) {
      emit(SignUpErrorState(error: e));
    }
  }

  final AuthRepository _authRepository;
}
