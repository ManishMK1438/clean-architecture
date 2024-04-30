import 'package:clean_art/core/exports.dart';
import 'package:clean_art/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthFirebaseDatasource {
  Future<UserModel> signUpWithEmailAndPass(
      {required String name, required String email, required String password});

  ResultVoid loginWithEmailAndPass(
      {required String email, required String password});
}

class AuthFirebaseDataSourceImpl extends AuthFirebaseDatasource {
  final FirebaseAuth _firebaseAuth;
  final _appStrings = AppStrings();
  AuthFirebaseDataSourceImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;
  @override
  ResultVoid loginWithEmailAndPass(
      {required String email, required String password}) {
    // TODO: implement loginWithEmailAndPass
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signUpWithEmailAndPass(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (response.user == null) {
        throw ServerError(message: _appStrings.userNotFound);
      }
      return UserModel(id: response.user!.uid, name: "");
    } on FirebaseAuthException catch (e, s) {
      throw ServerError(message: e.message!);
    } catch (e, s) {
      throw ServerError(message: e.toString());
    }
  }
}
