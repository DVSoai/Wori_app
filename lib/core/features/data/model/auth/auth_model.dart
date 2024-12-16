import 'package:wori_app/core/features/data/model/auth/user_model.dart';

class AuthModel {
  String? accessToken;
  String? refreshToken;
  UserModel? user;

  AuthModel({
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['accessToken']?? '',
      refreshToken: json['refreshToken']?? '',
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
}
  }