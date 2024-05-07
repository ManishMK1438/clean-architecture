import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String password;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
