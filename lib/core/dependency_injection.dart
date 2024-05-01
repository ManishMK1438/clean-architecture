import 'package:clean_art/features/auth/data/datasources/auth_firebase_datasource.dart';
import 'package:clean_art/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:clean_art/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_art/features/auth/domain/usecases/user_login.dart';
import 'package:clean_art/features/auth/domain/usecases/user_signup.dart';
import 'package:clean_art/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  serviceLocator.registerLazySingleton(() => _auth);
}

_initAuth() {
  //datasource
  serviceLocator
    ..registerFactory<AuthFirebaseDatasource>(
      () => AuthFirebaseDataSourceImpl(
        firebaseAuth: serviceLocator(),
      ),
    )
    //repository
    ..registerFactory<AuthRepository>(
      () => AuthRepoImpl(
        datasource: serviceLocator(),
      ),
    )
    //useCases
    ..registerFactory(
      () => UserSignUp(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        repository: serviceLocator(),
      ),
    )
    //BLOC
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
      ),
    );
}
