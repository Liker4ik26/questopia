part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

final class LoadUserEvent extends ProfileEvent {
  const LoadUserEvent({
    required this.completer,
  });

  final Completer? completer;

  @override
  List<Object?> get props => super.props..add(completer);
}

final class LogOutEvent extends ProfileEvent {
  const LogOutEvent();
}
