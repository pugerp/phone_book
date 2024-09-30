import 'package:dartz/dartz.dart';
import 'package:phone_book/data/data_sources/remote/user_remote_datasource.dart';
import 'package:phone_book/data/models/user.dart';
import 'package:phone_book/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDatasource remote;

  UserRepositoryImpl({required this.remote});

  @override
  Future<Either<String, String>> registration({required User user}) async {
    try {
      final result = await remote.registration(user: user);
      return const Right('Success Registration');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, User>> login({required String username, required String password}) async {
    try {
      final result = await remote.login(username: username, password: password);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }


}