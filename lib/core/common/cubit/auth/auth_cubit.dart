import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questopia/core/repositories/auth/data/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthState()) {
    getCurrentAuthState();
  }

  void getCurrentAuthState() {
    _authRepository.getCurrentAuthState().listen((event) {
      print(event.event.name);
      emit(
        AuthState(session: event.session),
      );
    });
  }

  final AuthRepository _authRepository;
}
