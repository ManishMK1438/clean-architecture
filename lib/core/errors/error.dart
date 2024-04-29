import 'package:equatable/equatable.dart';

abstract class AppError extends Equatable {
  final String message;
  final int? statusCode;

  const AppError({
    required this.message,
    this.statusCode,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [statusCode, message];
}

class ServerError extends AppError {
  const ServerError({required super.message, super.statusCode});
}
