import 'package:bloc/bloc.dart';
import 'package:clean_art/core/common/entity/user.dart';
import 'package:equatable/equatable.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  updateUser({User? user}) {
    if (user == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedIn(user: user));
    }
  }
}
