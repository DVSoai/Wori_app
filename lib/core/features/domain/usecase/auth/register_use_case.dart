import '../../entities/auth/user_entity.dart';
import '../../repositories/auth/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<UserEntity>call(String username, String email, String password) async {
    return await repository.register(username, email, password);
  }
}