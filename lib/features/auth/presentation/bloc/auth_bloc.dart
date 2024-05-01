import 'package:bloc/bloc.dart';
import 'package:clean_art/core/exports.dart';

import '../../domain/usecases/user_login.dart';
import '../../domain/usecases/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;

  AuthBloc({required UserSignUp userSignUp, required UserLogin userLogin})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) => _signUp(event, emit));
    on<AuthLogin>(_login);
  }

  _signUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userSignUp(UserSignupParams(
        name: event.name, email: event.email, password: event.password));

    response.fold(
        (l) => emit(AuthFailure(error: l.message)), (r) => emit(AuthSuccess()));
  }

  _login(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));

    response.fold(
        (l) => emit(AuthFailure(error: l.message)), (r) => emit(AuthSuccess()));
  }
}
