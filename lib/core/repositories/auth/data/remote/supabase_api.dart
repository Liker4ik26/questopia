import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseApi {
  SupabaseApi({
    required Supabase supabase,
    required String url,
    required String apiKey,
  }) : _supabase = supabase;

  final Supabase _supabase;

  Future<AuthResponse> signIn(
      {required String email, required String password}) async {
    final response = await _supabase.client.auth
        .signInWithPassword(email: email, password: password);
    return response;
  }

  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    final response = await _supabase.client.auth.signUp(
      email: email,
      password: password,
    );
    await _supabase.client.from('users').insert({
      'id': response.user!.id,
      'FIO': 'фио',
      'phone': 'телефон',
      'email': response.user!.email,
    });
    return response;
  }

  Stream<AuthState> getCurrentAuthState() {
    print(_supabase.client.auth.onAuthStateChange.map(
      (authState) => authState,
    ));

    return _supabase.client.auth.onAuthStateChange;
  }

  Future<void> signOut() async {
    await _supabase.client.auth.signOut();
  }
}
