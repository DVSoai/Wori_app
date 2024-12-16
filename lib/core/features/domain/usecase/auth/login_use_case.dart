import '../../entities/auth/user_entity.dart';
import '../../repositories/auth/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<UserEntity>call(String email, String password) async {
    return await repository.login(email, password);
  }
}