import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFF1565C0);
const Color accentColor = Color(0xFFFFC107);

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  scaffoldBackgroundColor: const Color(0xFFF2F5FA),
  // Изменение шрифта
  textTheme: GoogleFonts.robotoSlabTextTheme(),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    titleTextStyle: GoogleFonts.robotoSlab(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      minimumSize: const Size.fromHeight(50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  ),
);