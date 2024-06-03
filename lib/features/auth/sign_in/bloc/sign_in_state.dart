part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState {
   const SignInState();
}

final class SignInInitialState extends SignInState {
   const SignInInitialState();
}

final class SignInLoadingState extends SignInState {
   const SignInLoadingState();
}

final class SignInLoadedState extends SignInState {
   const SignInLoadedState();
}

final class SignInErrorState extends SignInState {
   const SignInErrorState({required this.error});

   final Object? error;
}