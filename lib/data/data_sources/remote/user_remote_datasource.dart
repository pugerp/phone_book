import 'package:phone_book/root/utilities/services/database_service.dart';

import '../../models/user.dart';

abstract class UserRemoteDatasource {
  Future<void> registration({required User user});

  Future<User> login({
    required String username,
    required String password,
  });
}

class UserRemoteDatasourceImpl extends UserRemoteDatasource {
  final DatabaseService service;

  UserRemoteDatasourceImpl({required this.service});

  @override
  Future<User> login(
      {required String username, required String password}) async {
    final response =
        await service.userRef.where('username', isEqualTo: username).get();

    if (response.docs.isEmpty) {
      throw Exception('User is not found');
    }

    var user = response.docs.first.data() as User;

    if (user.passowrd == password) {
      return user;
    } else {
      throw Exception('Username or Password is wrong');
    }
  }

  @override
  Future<void> registration({required User user}) async =>
      await service.userRef.add(user);
}
