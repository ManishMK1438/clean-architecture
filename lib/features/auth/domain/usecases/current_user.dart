import 'package:clean_art/core/exports.dart';
import 'package:clean_art/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/common/entity/user.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository _repository;
  CurrentUser({required AuthRepository repository}) : _repository = repository;

  @override
  ResultFuture<User> call(NoParams params) async {
    return await _repository.getCurrentUser();
  }
}
