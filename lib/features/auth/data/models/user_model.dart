import '../../../../core/common/entity/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.email,
      required super.name,
      required super.password});

  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'] ?? "",
        name: json['name'] ?? "User",
        email: json['email'] ?? "",
        password: json['password'] ?? "");
  }
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, password: $password}';
  }
}
