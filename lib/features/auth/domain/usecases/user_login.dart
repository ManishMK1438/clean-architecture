import 'package:clean_art/core/exports.dart';
import 'package:clean_art/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/common/entity/user.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository _authRepository;

  UserLogin({required AuthRepository repository})
      : _authRepository = repository;

  @override
  ResultFuture<User> call(UserLoginParams params) async {
    return await _authRepository.loginWithEmailAndPass(
        email: params.email, password: params.password);
  }
}

class UserLoginParams extends Equatable {
  final String email;
  final String password;

  const UserLoginParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
