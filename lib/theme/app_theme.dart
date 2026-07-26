import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTheme {
  static const ink = Color(0xFF12110F);
  static const surface = Color(0xFF1B1916);
  static const card = Color(0xFF24211D);
  static const cream = Color(0xFFF2E8D5);
  static const gold = Color(0xFFD6AE68);
  static const muted = Color(0xFFB9AE9D);

  static final dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: gold,
      onPrimary: ink,
      secondary: Color(0xFF83B9AA),
      surface: surface,
      onSurface: cream,
      outline: Color(0xFF4B4439),
    ),
    scaffoldBackgroundColor: ink,
    textTheme: GoogleFonts.dmSansTextTheme(ThemeData.dark().textTheme).copyWith(
      displaySmall: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
      headlineSmall: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
      titleLarge: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: ink, surfaceTintColor: Colors.transparent),
    cardTheme: CardThemeData(
      color: card,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: surface,
      indicatorColor: Color(0xFF4A3B24),
      labelTextStyle: WidgetStatePropertyAll(TextStyle(fontWeight: FontWeight.w600)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: card,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
  );
}
