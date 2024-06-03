import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRepository {
  const AuthRepository._();

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  });

  Future<AuthResponse> signUp({
    required String email,
    required String password,
  });
  Future<void> signOut();
  Stream<AuthState> getCurrentAuthState();
}
