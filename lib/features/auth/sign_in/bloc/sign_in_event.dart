part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {
  const SignInEvent();
}

final class LogInEvent extends SignInEvent {
  const LogInEvent({required this.email, required this.password});

  final String email;
  final String password;
}
