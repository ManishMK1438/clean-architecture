import 'package:clean_art/core/exports.dart';

abstract interface class UseCase<T, Params> {
  ResultFuture<T> call(Params params);
}
