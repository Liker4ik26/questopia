part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {
  const SignUpEvent();
}

final class RegistrationEvent extends SignUpEvent {
  const RegistrationEvent({required this.email, required this.password});

  final String email;
  final String password;
}
