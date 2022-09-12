import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'nittiv-color.dart';

class NittivTheme {
  ThemeData get lightTheme => ThemeData(
        primarySwatch: NittivColors.primaryGreen,
        backgroundColor: NittivColors.background,
        primaryColor: NittivColors.primaryGreen,
        errorColor: NittivColors.tertiaryRed,
        fontFamily: GoogleFonts.poppins().fontFamily,
        appBarTheme: const AppBarTheme(
          backgroundColor: NittivColors.primaryGreen,
          foregroundColor: NittivColors.background,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: NittivColors.primaryGreen,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: NittivColors.primaryGreen,
              width: 2.5,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: NittivColors.primaryGreen,
            ),
          ),
        ),
        textTheme: TextTheme(
          headlineMedium:
              TextStyle(fontWeight: FontWeight.w800, color: NittivColors.base.shade800),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: GoogleFonts.openSans().fontStyle,
            ),
          ),
        ),
      );
}
