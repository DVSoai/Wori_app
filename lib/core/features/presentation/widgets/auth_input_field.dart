import 'package:flutter/material.dart';

import '../../../constants/padding.dart';
import '../../../constants/size_box.dart';
import '../../../theme.dart';

class AuthInputField extends StatelessWidget {
  const AuthInputField({super.key, required this.hint, required this.icon, required this.controller,  this.isPassword = false});
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final bool isPassword;


  @override
  Widget build(BuildContext context) {
   return Container(
      decoration: BoxDecoration(
        color: DefaultColors.sentMessageInput,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: PaddingConstants.padSymH20,
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey,
          ),
          SizedBoxConstants.sizedBoxW10,
          Expanded(
              child: TextField(
                controller: controller,
                obscureText: isPassword,
                decoration: InputDecoration(
                  hintText: hint,
                  border: InputBorder.none,
                  hintStyle: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ))
        ],
      ),
    );
  }
}
