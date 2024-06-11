part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileEvent {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

final class EditProfileLoadingState extends EditProfileState {
  const EditProfileLoadingState();
}

final class EditProfileErrorState extends EditProfileState {
  const EditProfileErrorState({
    required this.error,
  });

  final Object? error;
}

final class SaveUserEvent extends EditProfileEvent {
  const SaveUserEvent({
    required this.user,
  });

  final UserDomain user;
}

final class LoadUserEvent extends EditProfileEvent {
  const LoadUserEvent({
    required this.completer,
  });

  final Completer? completer;

  @override
  List<Object?> get props => super.props..add(completer);
}

final class UserLoadEvent extends EditProfileEvent {
  const UserLoadEvent({
    required this.completer,
  });

  final Completer? completer;

  @override
  List<Object?> get props => super.props..add(completer);
}
