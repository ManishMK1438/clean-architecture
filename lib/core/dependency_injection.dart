import 'package:clean_art/core/exports.dart';
import 'package:clean_art/features/auth/data/datasources/auth_firebase_datasource.dart';
import 'package:clean_art/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:clean_art/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_art/features/auth/domain/usecases/current_user.dart';
import 'package:clean_art/features/auth/domain/usecases/user_login.dart';
import 'package:clean_art/features/auth/domain/usecases/user_signup.dart';
import 'package:clean_art/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_art/features/blogs/data/datasources/blog_firebase_datasource.dart';
import 'package:clean_art/features/blogs/data/repositories/blog_repo_impl.dart';
import 'package:clean_art/features/blogs/domain/repository/blog_repository.dart';
import 'package:clean_art/features/blogs/domain/usecases/fetch_blogs.dart';
import 'package:clean_art/features/blogs/domain/usecases/upload_blog.dart'
    as use_case;
import 'package:clean_art/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  //firebase auth initialization
  final FirebaseAuth _auth = FirebaseAuth.instance;
  serviceLocator.registerLazySingleton(() => _auth);

  //firebase storage initialization
  final FirebaseStorage _storage = FirebaseStorage.instance;
  serviceLocator.registerLazySingleton(() => _storage);

  //firebase fireStore initialization
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  serviceLocator.registerLazySingleton(() => _firestore);

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

_initAuth() {
  //datasource
  serviceLocator
    ..registerFactory<AuthFirebaseDatasource>(
      () => AuthFirebaseDataSourceImpl(
        firebaseAuth: serviceLocator(),
        fireStore: serviceLocator(),
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
    ..registerFactory(
      () => CurrentUser(
        repository: serviceLocator(),
      ),
    )
    //BLOC
    ..registerLazySingleton(
      () => AuthBloc(
          userSignUp: serviceLocator(),
          userLogin: serviceLocator(),
          currentUser: serviceLocator(),
          appUserCubit: serviceLocator()),
    );
}

_initBlog() {
  //datasource
  serviceLocator
    ..registerFactory<BlogFirebaseDataSource>(
      () => BlogFirebaseDataSourceImpl(
        fireStore: serviceLocator(),
        storage: serviceLocator(),
      ),
    )
    //repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        dataSource: serviceLocator(),
      ),
    )
    //useCases
    ..registerFactory(
      () => use_case.UploadBlog(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => FetchBlogs(
        repository: serviceLocator(),
      ),
    )
    //BLOC
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlogUseCase: serviceLocator(),
        fetchBlogs: serviceLocator(),
      ),
    );
}
