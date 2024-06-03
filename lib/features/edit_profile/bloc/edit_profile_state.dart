part of 'edit_profile_bloc.dart';

abstract class EditProfileState {
  const EditProfileState();
}

final class EditProfileInitialState extends EditProfileState {
  const EditProfileInitialState();
}

final class EditProfileLoadingState extends EditProfileState {
  const EditProfileLoadingState();
}

final class EditProfileLoadedState extends EditProfileState {
  const EditProfileLoadedState();
}

final class EditProfileErrorState extends EditProfileState {
  const EditProfileErrorState({
    required this.error,
  });

  final Object? error;
}
