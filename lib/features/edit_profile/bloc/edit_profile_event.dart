part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileEvent {
  const EditProfileEvent();
}

final class SaveUserEvent extends EditProfileEvent {
  const SaveUserEvent({
    required this.user,
  });

  final UserDomain user;
}