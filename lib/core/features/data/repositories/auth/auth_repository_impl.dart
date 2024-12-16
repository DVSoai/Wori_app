import 'package:wori_app/core/features/data/datasources/auth/auth_remote_data_source.dart';
import 'package:wori_app/core/features/domain/entities/auth/user_entity.dart';

import '../../../domain/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<UserEntity> login(String email, String password)async {
    return await authRemoteDataSource.login(email: email, password: password);
  }

  @override
  Future<UserEntity> register(String username, String email, String password)async {
    return await authRemoteDataSource.register(username: username, email: email, password: password);
  }

}