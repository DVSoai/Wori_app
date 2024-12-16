import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontSizes {

  static const double small = 12.0;
  static const double standard = 14.0;
  static const double standardUp = 16.0;
  static const double medium = 20.0;
  static const double large = 28.0;
}

class DefaultColors {
  static const Color greyText = Color(0xFFB3B9C9);
  static const Color whiteText = Color(0xFFFFFFFF);
  static const Color senderMessage = Color(0xFF7A8194);
  static const Color receiverMessage = Color(0xFF373E4E);
  static const Color sentMessageInput = Color(0xFF3D4354);
  static const Color messageListPage = Color(0xFF292F3F);
  static const Color buttonColor = Color(0xFF7A8194);
  static const Color primaryColor = Color(0xFF0042A9);
}
class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.white,
      appBarTheme: const  AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: const Color(0xFF1B202D),
      textTheme: TextTheme(
        titleMedium: GoogleFonts.alegreyaSans(
          fontSize: FontSizes.medium,
          color: Colors.white,
        ),
        titleLarge: GoogleFonts.alegreyaSans(
          fontSize: FontSizes.large,
          color: Colors.white,
        ),
        bodySmall: GoogleFonts.alegreyaSans(
          fontSize: FontSizes.standardUp,
          color: Colors.white,
        ),
        bodyMedium: GoogleFonts.alegreyaSans(
          fontSize: FontSizes.standard,
          color: Colors.white,
        ),
        bodyLarge: GoogleFonts.alegreyaSans(
          fontSize: FontSizes.standardUp,
          color: Colors.white,
        ),
      )
    );
  }
}