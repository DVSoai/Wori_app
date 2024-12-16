
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wori_app/core/constants/padding.dart';
import 'package:wori_app/core/constants/size_box.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_input_field.dart';
import '../../widgets/button_prompt.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  void _onLogin() {
    BlocProvider.of<AuthBloc>(context).add(
        LoginEvent(email: _emailController.text.trim(),
            password: _passwordController.text.trim())
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: PaddingConstants.padAll20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBoxConstants.sizedBoxH20,
              AuthInputField(hint:"Email" , icon: Icons.email, controller: _emailController),
              SizedBoxConstants.sizedBoxH20,
              AuthInputField(hint:"Password" , icon: Icons.lock, controller: _passwordController,isPassword: true,),
              SizedBoxConstants.sizedBoxH20,
              BlocConsumer<AuthBloc, AuthState>(builder: (context, state){
                if(state is AuthLoading){
                  return const Center(child: CircularProgressIndicator(),);
                }
                return AuthButton(onPressed: _onLogin, text: 'Login');
              }, listener:(context,state){
                if(state is AuthSuccess){
                  Navigator.pushNamedAndRemoveUntil(context, '/conversationPage',(route) => false);
                } else if(state is AuthFailure){
                  debugPrint(state.error);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error))
                  );
                }
              }),
              SizedBoxConstants.sizedBoxH20,
              ButtonPrompt(title: "Don't have an account ", subtitle: 'Click hero to register', onPressed: (){
                Navigator.pushNamed(context, '/register');
              })
            ],
          ),
        ),
      ),
    );
  }

}
