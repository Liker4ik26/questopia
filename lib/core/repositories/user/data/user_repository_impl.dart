import 'package:questopia/core/repositories/user/data/remote/user_api.dart';
import 'package:questopia/core/repositories/user/data/user_repository.dart';
import 'package:questopia/core/repositories/user/domain/user_domain.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({
    required UserApi userApi,
  }) : _userApi = userApi;

  final UserApi _userApi;

  @override
  Future<void> signOut() async {
    await _userApi.signOut();
  }

  @override
  Future<void> addUser({
    required UserDomain userDomain,
  }) async {
    await _userApi.addUser(userDomain: userDomain,);
  }

  @override
  Future<UserDomain> getUserById() async {
    final response = await _userApi.getUserById();
    return response;
  }
}
