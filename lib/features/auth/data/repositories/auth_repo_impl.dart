import 'package:clean_art/core/exports.dart';
import 'package:clean_art/features/auth/data/datasources/auth_firebase_datasource.dart';
import 'package:clean_art/features/auth/domain/entity/user.dart';
import 'package:clean_art/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthFirebaseDatasource _datasource;
  AuthRepoImpl({required AuthFirebaseDatasource datasource})
      : _datasource = datasource;
  @override
  ResultFuture<User> loginWithEmailAndPass(
      {required String email, required String password}) {
    return _wrapper(
        fn: () async => await _datasource.loginWithEmailAndPass(
            email: email, password: password));
  }

  @override
  ResultFuture<User> signUpWithEmailAndPass(
      {required String name,
      required String email,
      required String password}) async {
    return _wrapper(
        fn: () async => await _datasource.signUpWithEmailAndPass(
            name: name, email: email, password: password));
  }

  ResultFuture<User> _wrapper({
    required Future<User> Function() fn,
  }) async {
    try {
      final user = await fn();
      return Right(user);
    } on ServerError catch (e) {
      return Left(ServerError(message: e.message));
    }
  }
}
