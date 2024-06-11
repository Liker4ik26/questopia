part of 'edit_profile_bloc.dart';

abstract class EditProfileState {
  const EditProfileState();
}

final class EditProfileInitialState extends EditProfileState {
  const EditProfileInitialState();
}

final class EditProfileLoadedState extends EditProfileState {
  const EditProfileLoadedState();
}

final class UserLoadingState extends EditProfileState {
  const UserLoadingState();
}

final class UserLoadedState extends EditProfileState {
  const UserLoadedState({
    required this.user,
  });

  final UserDomain user;
}

final class UserErrorState extends EditProfileState {
  const UserErrorState({
    required this.error,
  });

  final Object? error;
}
