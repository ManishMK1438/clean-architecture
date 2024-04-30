import 'package:clean_art/features/auth/domain/entity/user.dart';

class UserModel extends User {
  const UserModel({required super.id, required super.name});

  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(id: json['id'], name: json['name']);
  }
}
