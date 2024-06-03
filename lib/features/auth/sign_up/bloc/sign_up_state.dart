part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {
  const SignUpState();
}

final class SignUpInitialState extends SignUpState {
  const SignUpInitialState();
}

final class SignUpLoadingState extends SignUpState {
  const SignUpLoadingState();
}

final class SignUpLoadedState extends SignUpState {
  const SignUpLoadedState();
}

final class SignUpErrorState extends SignUpState {
  const SignUpErrorState({required this.error});

  final Object? error;
}
