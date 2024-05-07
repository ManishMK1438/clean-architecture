import 'package:clean_art/core/exports.dart';
import 'package:clean_art/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthFirebaseDatasource {
  User? get getCurrentSession;
  Future<UserModel> signUpWithEmailAndPass(
      {required String name, required String email, required String password});

  Future<UserModel> loginWithEmailAndPass(
      {required String email, required String password});

  Future<void> saveUserDetails({required UserModel model});

  Future<UserModel?> getCurrentUserData();
}

class AuthFirebaseDataSourceImpl extends AuthFirebaseDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _fireStore;
  final _appStrings = AppStrings();

  AuthFirebaseDataSourceImpl(
      {required FirebaseAuth firebaseAuth,
      required FirebaseFirestore fireStore})
      : _firebaseAuth = firebaseAuth,
        _fireStore = fireStore;

  @override
  Future<UserModel> loginWithEmailAndPass(
      {required String email, required String password}) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (response.user == null) {
        throw ServerError(message: _appStrings.userNotFound);
      }
      return UserModel(
          id: response.user!.uid,
          email: response.user!.email ?? email,
          name: response.user!.displayName ?? "",
          password: password);
    } on FirebaseAuthException catch (e, s) {
      throw ServerError(message: e.message!);
    } catch (e, s) {
      throw ServerError(message: e.toString());
    }
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
      return UserModel(
          id: response.user!.uid,
          email: response.user!.email ?? email,
          name: name,
          password: password);
    } on FirebaseAuthException catch (e, s) {
      throw ServerError(message: e.message!);
    } catch (e, s) {
      throw ServerError(message: e.toString());
    }
  }

  @override
  Future<void> saveUserDetails({required UserModel model}) async {
    try {
      final response = await _fireStore
          .collection("Users")
          .doc(model.id)
          .set(model.toJSON());
    } on FirebaseException catch (e, s) {
      throw ServerError(message: e.message!);
    } catch (e, s) {
      throw ServerError(message: e.toString());
    }
  }

  @override
  User? get getCurrentSession => _firebaseAuth.currentUser;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (getCurrentSession != null) {
        final response = await _fireStore
            .collection("Users")
            .doc(getCurrentSession?.uid)
            .get();
        return UserModel.fromJSON(response.data() ?? {});
      }
      return null;
    } on FirebaseException catch (e, s) {
      throw ServerError(message: e.message!);
    } catch (e, s) {
      throw ServerError(message: e.toString());
    }
  }
}
