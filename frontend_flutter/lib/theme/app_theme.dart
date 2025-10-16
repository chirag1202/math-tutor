import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Color Palettes for Math Tutor App
/// 
/// LIGHT THEME PALETTE 1: Playful Sky
/// Primary: #6366F1 (Indigo) - Calm, trustworthy, learning-focused
/// Secondary: #FFA726 (Orange) - Fun, energetic, encouraging
/// Accent: #26C6DA (Cyan) - Fresh, playful
/// Background: #F8FAFC (Light blue-grey) - Soft, easy on eyes
/// 
/// LIGHT THEME PALETTE 2: Cheerful Garden
/// Primary: #8B5CF6 (Purple) - Creative, magical
/// Secondary: #10B981 (Green) - Growth, success
/// Accent: #F59E0B (Amber) - Warm, exciting
/// Background: #FEFCE8 (Light yellow) - Sunny, cheerful
///
/// DARK THEME PALETTE 1: Starry Night
/// Primary: #818CF8 (Light Indigo) - Gentle on eyes
/// Secondary: #FBBF24 (Yellow) - Warm, inviting
/// Accent: #34D399 (Emerald) - Fresh, positive
/// Background: #1E293B (Slate) - Not too dark, comfortable
///
/// DARK THEME PALETTE 2: Midnight Adventure
/// Primary: #A78BFA (Light Purple) - Dreamy, magical
/// Secondary: #FB923C (Light Orange) - Cozy, friendly
/// Accent: #60A5FA (Light Blue) - Calm, focused
/// Background: #334155 (Blue-grey) - Balanced darkness

class AppTheme {
  // Light Theme Palette 1: Playful Sky
  static const Color _lightPrimary = Color(0xFF6366F1);
  static const Color _lightSecondary = Color(0xFFFFA726);
  static const Color _lightAccent = Color(0xFF26C6DA);
  static const Color _lightBackground = Color(0xFFF8FAFC);
  static const Color _lightSurface = Colors.white;
  static const Color _lightCardColor = Colors.white;

  // Dark Theme Palette 1: Starry Night
  static const Color _darkPrimary = Color(0xFF818CF8);
  static const Color _darkSecondary = Color(0xFFFBBF24);
  static const Color _darkAccent = Color(0xFF34D399);
  static const Color _darkBackground = Color(0xFF1E293B);
  static const Color _darkSurface = Color(0xFF334155);
  static const Color _darkCardColor = Color(0xFF334155);

  // Reward colors (theme-independent)
  static const Color goldStar = Color(0xFFFFD700);
  static const Color silverStar = Color(0xFFC0C0C0);
  static const Color bronzeStar = Color(0xFFCD7F32);

  // Success/Error colors (adjusted for each theme)
  static const Color lightSuccess = Color(0xFF10B981);
  static const Color lightError = Color(0xFFEF4444);
  static const Color darkSuccess = Color(0xFF34D399);
  static const Color darkError = Color(0xFFF87171);

  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: _lightPrimary,
      scaffoldBackgroundColor: _lightBackground,
      cardColor: _lightCardColor,
      colorScheme: ColorScheme.light(
        primary: _lightPrimary,
        secondary: _lightSecondary,
        tertiary: _lightAccent,
        surface: _lightSurface,
        background: _lightBackground,
        error: lightError,
      ),
      
      // Custom font - Nunito for readability and playfulness
      textTheme: GoogleFonts.nunitoTextTheme(
        ThemeData.light().textTheme.copyWith(
          displayLarge: GoogleFonts.nunito(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E293B),
          ),
          displayMedium: GoogleFonts.nunito(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E293B),
          ),
          displaySmall: GoogleFonts.nunito(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E293B),
          ),
          headlineMedium: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
          titleLarge: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
          bodyLarge: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF475569),
          ),
          bodyMedium: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF64748B),
          ),
          labelLarge: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      
      // Rounded corners everywhere
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: _lightCardColor,
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: _lightPrimary,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _lightSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF1E293B),
        titleTextStyle: GoogleFonts.nunito(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF1E293B),
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: _lightPrimary.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _lightPrimary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: _lightPrimary,
        unselectedItemColor: Colors.grey.shade400,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: GoogleFonts.nunito(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.nunito(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: _darkPrimary,
      scaffoldBackgroundColor: _darkBackground,
      cardColor: _darkCardColor,
      colorScheme: ColorScheme.dark(
        primary: _darkPrimary,
        secondary: _darkSecondary,
        tertiary: _darkAccent,
        surface: _darkSurface,
        background: _darkBackground,
        error: darkError,
      ),
      
      // Custom font - Nunito for readability and playfulness
      textTheme: GoogleFonts.nunitoTextTheme(
        ThemeData.dark().textTheme.copyWith(
          displayLarge: GoogleFonts.nunito(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFF1F5F9),
          ),
          displayMedium: GoogleFonts.nunito(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFF1F5F9),
          ),
          displaySmall: GoogleFonts.nunito(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFF1F5F9),
          ),
          headlineMedium: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFE2E8F0),
          ),
          titleLarge: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFE2E8F0),
          ),
          bodyLarge: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: const Color(0xFFCBD5E1),
          ),
          bodyMedium: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF94A3B8),
          ),
          labelLarge: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E293B),
          ),
        ),
      ),
      
      // Rounded corners everywhere
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: _darkCardColor,
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: _darkPrimary,
          foregroundColor: const Color(0xFF1E293B),
          textStyle: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _darkSecondary,
        foregroundColor: const Color(0xFF1E293B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFFF1F5F9),
        titleTextStyle: GoogleFonts.nunito(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: const Color(0xFFF1F5F9),
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: _darkPrimary.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _darkPrimary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _darkSurface,
        selectedItemColor: _darkPrimary,
        unselectedItemColor: Colors.grey.shade600,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: GoogleFonts.nunito(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.nunito(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
