import 'package:wori_app/core/features/domain/entities/auth/user_entity.dart';

abstract class AuthRepository {

  Future<UserEntity>login(String email, String password);
  Future<UserEntity>register(String username,String email, String password);

}