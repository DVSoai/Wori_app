import 'package:wori_app/core/features/domain/entities/auth/user_entity.dart';

class UserModel extends UserEntity {
   UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.password,
    required super.token,
     required super.profileImage,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?? '',
      username: json['username']?? '',
      email: json['email']?? '',
      password: json['password']?? '',
      token: json['token']?? '',
      profileImage: json['profile_image']?? '',
    );
  }
}
