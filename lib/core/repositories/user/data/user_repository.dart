import '../domain/user_domain.dart';

abstract interface class UserRepository {
  const UserRepository._();

  Future<void> addUser({
    required UserDomain userDomain,
  });

  Future<UserDomain> getUserById();

  Future<void> signOut();
}
