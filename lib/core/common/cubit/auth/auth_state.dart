part of 'auth_cubit.dart';

class AuthState {
  final Session? session;
  final AuthException? error;

  AuthState({
    this.session,
    this.error,
  });
}
