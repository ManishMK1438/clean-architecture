import 'package:clean_art/core/exports.dart';

import '../../../../core/common/entity/user.dart';

abstract interface class AuthRepository {
  ResultFuture<User> signUpWithEmailAndPass(
      {required String name, required String email, required String password});

  ResultFuture<User> loginWithEmailAndPass(
      {required String email, required String password});

  ResultVoid saveUserInfo(
      {required String name,
      required String id,
      required String password,
      required String email});

  ResultFuture<User> getCurrentUser();
}
