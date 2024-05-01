part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

final class AuthSignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const AuthSignUp({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name, email, password];
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthLogin({
    required this.email,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}
