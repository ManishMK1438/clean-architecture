import 'package:clean_art/core/exports.dart';
import 'package:clean_art/features/auth/domain/entity/user.dart';
import 'package:clean_art/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<User, UserSignupParams> {
  final AuthRepository _authRepository;
  UserSignUp({required AuthRepository authRepository})
      : _authRepository = authRepository;
  @override
  ResultFuture<User> call(UserSignupParams params) async {
    return await _authRepository.signUpWithEmailAndPass(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignupParams extends Equatable {
  final String name;
  final String email;
  final String password;

  const UserSignupParams({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name, email, password];
}
