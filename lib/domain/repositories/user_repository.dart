import 'package:dartz/dartz.dart';

import '../../data/models/user.dart';

abstract class UserRepository {
  Future<Either<String, String>> registration({required User user});
  Future<Either<String, User>> login({required String username, required String password});
}
