import 'package:questopia/core/repositories/auth/data/auth_repository.dart';
import 'package:questopia/core/repositories/auth/data/remote/supabase_api.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required SupabaseApi supabaseApi,
  }) : _supabaseApi = supabaseApi;

  final SupabaseApi _supabaseApi;

  @override
  Future<AuthResponse> signIn(
      {required String email, required String password}) async {
    final response =
        await _supabaseApi.signIn(email: email, password: password);
    return response;
  }

  @override
  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    final response = await _supabaseApi.signUp(
      email: email,
      password: password,
    );
    return response;
  }

  @override
  Future<void> signOut() async {
    await _supabaseApi.signOut();
  }

  @override
  Stream<AuthState> getCurrentAuthState() => _supabaseApi.getCurrentAuthState();
}
