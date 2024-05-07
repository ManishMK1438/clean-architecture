import 'package:bloc/bloc.dart';
import 'package:clean_art/core/common/entity/user.dart';
import 'package:clean_art/core/exports.dart';

import '../../domain/usecases/current_user.dart';
import '../../domain/usecases/user_login.dart';
import '../../domain/usecases/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc(
      {required UserSignUp userSignUp,
      required UserLogin userLogin,
      required CurrentUser currentUser,
      required AppUserCubit appUserCubit})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(AuthLoading()));
    on<AuthSignUp>((event, emit) => _signUp(event, emit));
    on<AuthLogin>(_login);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  _signUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final response = await _userSignUp(UserSignupParams(
        name: event.name, email: event.email, password: event.password));

    response.fold((l) => emit(AuthFailure(error: l.message)),
        (r) => _emitAuthSuccess(user: r, emit: emit));
  }

  _login(AuthLogin event, Emitter<AuthState> emit) async {
    final response = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));

    response.fold((l) => emit(AuthFailure(error: l.message)),
        (r) => _emitAuthSuccess(user: r, emit: emit));
  }

  _isUserLoggedIn(AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());
    res.fold((l) => emit(AuthFailure(error: l.message)),
        (r) => _emitAuthSuccess(user: r, emit: emit));
  }

  _emitAuthSuccess({required User user, required Emitter<AuthState> emit}) {
    _appUserCubit.updateUser(user: user);
    emit(AuthSuccess());
  }
}
