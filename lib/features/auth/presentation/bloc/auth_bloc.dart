import 'package:bloc/bloc.dart';
import 'package:clean_art/core/exports.dart';

import '../../domain/usecases/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({required UserSignUp userSignUp})
      : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) => _signUp(event, emit));
  }

  _signUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final response = await _userSignUp(UserSignupParams(
        name: event.name, email: event.email, password: event.password));

    response.fold(
        (l) => emit(AuthFailure(error: l.message)), (r) => emit(AuthSuccess()));
  }
}
