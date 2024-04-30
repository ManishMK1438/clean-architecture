part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthSuccess extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthFailure extends AuthState {
  final String error;

  const AuthFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
