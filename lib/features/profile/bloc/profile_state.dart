part of 'profile_bloc.dart';

abstract class ProfileState {
  const ProfileState();
}

final class ProfileInitialState extends ProfileState {
  const ProfileInitialState();
}

final class ProfileLoadingState extends ProfileState {
  const ProfileLoadingState();
}

final class ProfileLoadedState extends ProfileState {
  const ProfileLoadedState({
    required this.user,
  });

  final UserDomain user;
}

final class ProfileErrorState extends ProfileState {
  const ProfileErrorState({
    required this.error,
  });

  final Object? error;
}

final class LogOutErrorState extends ProfileState {
  const LogOutErrorState({required this.error});

  final Object? error;
}

final class LogOutSuccessState extends ProfileState {
  const LogOutSuccessState();
}

final class LogOutLoadingState extends ProfileState {
  const LogOutLoadingState();
}
