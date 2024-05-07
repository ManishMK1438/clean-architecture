import 'package:clean_art/core/exports.dart';
import 'package:clean_art/features/auth/data/datasources/auth_firebase_datasource.dart';
import 'package:clean_art/features/auth/data/models/user_model.dart';
import 'package:clean_art/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entity/user.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthFirebaseDatasource _datasource;
  final _appStrings = AppStrings();
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
    return _wrapper(fn: () async {
      final user = await _datasource.signUpWithEmailAndPass(
          name: name, email: email, password: password);
      //saving user info
      await saveUserInfo(
          name: user.name,
          id: user.id,
          password: user.password,
          email: user.email);
      return user;
    });
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

  @override
  ResultVoid saveUserInfo(
      {required String name,
      required String id,
      required String password,
      required String email}) async {
    try {
      UserModel model =
          UserModel(id: id, email: email, name: name, password: password);

      final user = await _datasource.saveUserDetails(model: model);
      return Right(user);
    } on ServerError catch (e) {
      return Left(ServerError(message: e.message));
    }
  }

  @override
  ResultFuture<User> getCurrentUser() async {
    try {
      final user = await _datasource.getCurrentUserData();
      if (user == null) {
        return Left(ServerError(message: _appStrings.logInAgain));
      }
      return Right(user);
    } on ServerError catch (e) {
      return Left(ServerError(message: e.message));
    }
  }
}
