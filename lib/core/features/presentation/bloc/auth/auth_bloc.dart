
import 'package:flutter/cupertino.dart';
import 'package:wori_app/core/features/presentation/bloc/auth/auth_event.dart';
import 'package:wori_app/core/features/presentation/bloc/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../domain/usecase/auth/login_use_case.dart';
import '../../../domain/usecase/auth/register_use_case.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final _storage = const FlutterSecureStorage();
  AuthBloc({required this.registerUseCase, required this.loginUseCase}) : super(AuthInitial()){

    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
  }

  Future<void>  _onRegister(RegisterEvent event, Emitter<AuthState> emit)async{
    emit(AuthLoading());
    try{
      final user = await registerUseCase.call(event.username, event.email, event.password);
      debugPrint('user: $user');
      emit(AuthSuccess(message: 'Register successful'));
    }catch(e){
      debugPrint(e.toString());
      emit(AuthFailure(error: e.toString()));
    }
  }
 Future<void>  _onLogin(LoginEvent event, Emitter<AuthState> emit)async{
    emit(AuthLoading());
    try{
      final user = await loginUseCase.call( event.email, event.password);
      await _storage.write(key: 'token', value:user.token);
      await _storage.write(key: 'userId', value:user.id);
      print('token: ${user.token}');
      emit(AuthSuccess(message: 'Register successful'));
    }catch(e){
      emit(AuthFailure(error: e.toString()));
    }
  }

}