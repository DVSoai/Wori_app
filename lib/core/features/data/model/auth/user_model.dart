import 'package:wori_app/core/features/domain/entities/auth/user_entity.dart';

class UserModel extends UserEntity {
   UserModel({
    required String id,
    required String username,
    required String email,
    required String password,
    required String token,

  }):super(id: id, email: email, username: username, password: password, token: token);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?? '',
      username: json['username']?? '',
      email: json['email']?? '',
      password: json['password']?? '',
      token: json['token']?? '',
    );
  }
}
