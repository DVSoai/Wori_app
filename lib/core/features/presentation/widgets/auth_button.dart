import 'package:flutter/material.dart';

import '../../../constants/padding.dart';
import '../../../theme.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.onPressed, required this.text});
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: DefaultColors.buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: PaddingConstants.padSymV16,
      ),
      child:  Text(
        text,
        textAlign: TextAlign.center,
        style:const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
