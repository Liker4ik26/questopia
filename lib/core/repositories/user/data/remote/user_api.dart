import 'package:questopia/core/repositories/user/domain/user_domain.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserApi {
  UserApi({
    required Supabase supabase,
    required String url,
    required String apiKey,
  }) : _supabase = supabase;

  final Supabase _supabase;

  Future<void> addUser({
    required UserDomain userDomain,
  }) async {
    final userId = _supabase.client.auth.currentUser!.id;
    final userEmail = _supabase.client.auth.currentUser!.email;

    await _supabase.client.from('users').update({
      'FIO': userDomain.fio,
      'phone': userDomain.phone,
      'email': userEmail,
    }).eq('id', userId);
  }

  Future<UserDomain> getUserById() async {
    final userId = _supabase.client.auth.currentUser!.id;
    final response =
        await _supabase.client.from('users').select('*').eq('id', userId);
    final data = response;
    final dynamic user =
        data.map((jsonData) => UserDomain.fromJson(jsonData)).first;
    return user;
  }

  Future<void> signOut() async {
    await _supabase.client.auth.signOut();
  }
}
