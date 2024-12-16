import 'package:flutter/material.dart';

import '../../../theme.dart';

class ButtonPrompt extends StatelessWidget {
  const ButtonPrompt({super.key, required this.title, required this.subtitle, required this.onPressed});
  final String title, subtitle;
  final VoidCallback onPressed;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed,
        child: RichText(
          text: TextSpan(
            text: title,
            style: Theme.of(context).textTheme.bodyMedium,
            children:  [
              TextSpan(
                text: subtitle,
                style: const TextStyle(
                  color: DefaultColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
