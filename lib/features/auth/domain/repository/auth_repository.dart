import 'package:clean_art/core/exports.dart';
import 'package:clean_art/features/auth/domain/entity/user.dart';

abstract interface class AuthRepository {
  ResultFuture<User> signUpWithEmailAndPass(
      {required String name, required String email, required String password});

  ResultVoid loginWithEmailAndPass(
      {required String email, required String password});
}
