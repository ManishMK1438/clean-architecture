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
  ResultVoid loginWithEmailAndPass(
      {required String email, required String password}) {
    // TODO: implement loginWithEmailAndPass
    throw UnimplementedError();
  }

  @override
  ResultFuture<User> signUpWithEmailAndPass(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final userModel = await _datasource.signUpWithEmailAndPass(
          name: name, email: email, password: password);
      return Right(userModel);
    } on ServerError catch (e) {
      return Left(ServerError(message: e.message));
    }
  }
}
