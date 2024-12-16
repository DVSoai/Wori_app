class UserEntity {
  final String id;
  final String email;
  final String username;
  final String password;
  final String token;

  UserEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
     this.token = '',

  });

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'],
      email: map['email'],
      username: map['username'],
      password: map['password'],
      token: map['token'],


    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'password': password,
      'token': token,
    };
  }
}