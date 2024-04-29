import 'package:fpdart/fpdart.dart';

import '../errors/error.dart';

typedef ResultFuture<T> = Future<Either<AppError, T>>;
typedef ResultVoid = ResultFuture<void>;
