import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wori_app/core/constants/padding.dart';
import 'package:wori_app/core/constants/size_box.dart';
import 'package:wori_app/core/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:wori_app/core/features/presentation/bloc/auth/auth_event.dart';
import 'package:wori_app/core/features/presentation/bloc/auth/auth_state.dart';
import 'package:wori_app/core/features/presentation/widgets/auth_button.dart';
import 'package:wori_app/core/features/presentation/widgets/auth_input_field.dart';
import 'package:wori_app/core/features/presentation/widgets/button_prompt.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void _onRegister() {
    BlocProvider.of<AuthBloc>(context).add(
        RegisterEvent(username: _usernameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim()

        )
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
              AuthInputField(hint: "Username",
                  icon: Icons.person,
                  controller: _usernameController),
              SizedBoxConstants.sizedBoxH20,
              AuthInputField(hint: "Email",
                  icon: Icons.email,
                  controller: _emailController),
              SizedBoxConstants.sizedBoxH20,
              AuthInputField(hint: "Password",
                icon: Icons.lock,
                controller: _passwordController,
                isPassword: true,),
              SizedBoxConstants.sizedBoxH20,
              BlocConsumer<AuthBloc, AuthState>(builder: (context, state){
                if(state is AuthLoading){
                  return const Center(child: CircularProgressIndicator(),);
                }
                return AuthButton(onPressed: _onRegister, text: 'Register');
              }, listener:(context,state){
                if(state is AuthSuccess){
                  Navigator.pushNamed(context, '/login');
                } else if(state is AuthFailure){
                  debugPrint(state.error);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error))
                  );
                }
              }),
              SizedBoxConstants.sizedBoxH20,
              ButtonPrompt(title: 'Already have an account ',
                  subtitle: 'Click hero to login',
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  })
            ],
          ),
        ),
      ),
    );
  }

}
