import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF006e2f);
  static const Color primaryContainer = Color(0xFF22c55e);
  static const Color onPrimary = Color(0xFFffffff);
  
  static const Color secondary = Color(0xFF9d4300);
  static const Color secondaryContainer = Color(0xFFfd761a);
  static const Color onSecondary = Color(0xFFffffff);
  
  static const Color tertiary = Color(0xFF6d3bd7);
  static const Color tertiaryContainer = Color(0xFFb89cff);
  static const Color onTertiary = Color(0xFFffffff);
  
  static const Color error = Color(0xFFba1a1a);
  static const Color onError = Color(0xFFffffff);
  
  static const Color background = Color(0xFFf8f9ff);
  static const Color onBackground = Color(0xFF0b1c30);
  
  static const Color surface = Color(0xFFf8f9ff);
  static const Color surfaceContainer = Color(0xFFe5eeff);
  static const Color onSurface = Color(0xFF0b1c30);
  static const Color onSurfaceVariant = Color(0xFF3d4a3d);
  
  static const Color outline = Color(0xFF6d7b6c);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primary,
        primaryContainer: primaryContainer,
        onPrimary: onPrimary,
        secondary: secondary,
        secondaryContainer: secondaryContainer,
        onSecondary: onSecondary,
        tertiary: tertiary,
        tertiaryContainer: tertiaryContainer,
        onTertiary: onTertiary,
        error: error,
        onError: onError,
        background: background,
        onBackground: onBackground,
        surface: surface,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
      ),
      scaffoldBackgroundColor: background,
      textTheme: GoogleFonts.hankenGroteskTextTheme().copyWith(
        displayLarge: GoogleFonts.hankenGrotesk(
          fontSize: 48,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.02,
        ),
        headlineLarge: GoogleFonts.hankenGrotesk(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.01,
        ),
        headlineMedium: GoogleFonts.hankenGrotesk(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.hankenGrotesk(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: GoogleFonts.hankenGrotesk(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: GoogleFonts.hankenGrotesk(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.01,
        ),
        labelSmall: GoogleFonts.hankenGrotesk(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.02,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          textStyle: GoogleFonts.hankenGrotesk(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: const Color(0xFFF1F5F9),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
      ),
    );
  }
}
