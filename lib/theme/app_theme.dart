import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Background & Surface
  static const Color background = Color(0xFF001712);
  static const Color surface = Color(0xFF001712);
  static const Color surfaceDim = Color(0xFF001712);
  static const Color surfaceBright = Color(0xFF263E37);

  // Surface Containers
  static const Color surfaceContainerLowest = Color(0xFF00110D);
  static const Color surfaceContainerLow = Color(0xFF06201A);
  static const Color surfaceContainer = Color(0xFF0B241E);
  static const Color surfaceContainerHigh = Color(0xFF162E28);
  static const Color surfaceContainerHighest = Color(0xFF213933);

  // Primary
  static const Color primary = Color(0xFFD6C4A5);
  static const Color onPrimary = Color(0xFF392F19);
  static const Color primaryFixed = Color(0xFFF3E0C0);
  static const Color primaryFixedDim = Color(0xFFD6C4A5);
  static const Color primaryContainer = Color(0xFF281F0A);
  static const Color onPrimaryContainer = Color(0xFF95866A);
  static const Color onPrimaryFixed = Color(0xFF231A06);
  static const Color onPrimaryFixedVariant = Color(0xFF51452D);
  static const Color inversePrimary = Color(0xFF6A5D43);

  // Secondary
  static const Color secondary = Color(0xFFE9C176);
  static const Color onSecondary = Color(0xFF412D00);
  static const Color secondaryFixed = Color(0xFFFFDEA5);
  static const Color secondaryFixedDim = Color(0xFFE9C176);
  static const Color secondaryContainer = Color(0xFF604403);
  static const Color onSecondaryContainer = Color(0xFFDAB36A);
  static const Color onSecondaryFixed = Color(0xFF261900);
  static const Color onSecondaryFixedVariant = Color(0xFF5D4201);

  // Tertiary
  static const Color tertiary = Color(0xFFB1CCC3);
  static const Color onTertiary = Color(0xFF1D352E);
  static const Color tertiaryContainer = Color(0xFF0B241E);
  static const Color tertiaryFixed = Color(0xFFCDE9DF);
  static const Color tertiaryFixedDim = Color(0xFFB1CCC3);
  static const Color onTertiaryContainer = Color(0xFF738D84);
  static const Color onTertiaryFixed = Color(0xFF06201A);
  static const Color onTertiaryFixedVariant = Color(0xFF334C44);

  // On-Surface
  static const Color onBackground = Color(0xFFCDE9DF);
  static const Color onSurface = Color(0xFFCDE9DF);
  static const Color onSurfaceVariant = Color(0xFFC2C8C4);
  static const Color inverseSurface = Color(0xFFCDE9DF);
  static const Color inverseOnSurface = Color(0xFF1D352E);

  // Outline
  static const Color outline = Color(0xFF8C928F);
  static const Color outlineVariant = Color(0xFF424846);

  // Error
  static const Color error = Color(0xFFFFB4AB);
  static const Color onError = Color(0xFF690005);
  static const Color errorContainer = Color(0xFF93000A);
  static const Color onErrorContainer = Color(0xFFFFDAD6);

  // Surface Tint
  static const Color surfaceTint = Color(0xFFD6C4A5);
}

class AppTheme {
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.onPrimaryContainer,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: AppColors.onSecondaryContainer,
        tertiary: AppColors.tertiary,
        onTertiary: AppColors.onTertiary,
        tertiaryContainer: AppColors.tertiaryContainer,
        onTertiaryContainer: AppColors.onTertiaryContainer,
        error: AppColors.error,
        onError: AppColors.onError,
        errorContainer: AppColors.errorContainer,
        onErrorContainer: AppColors.onErrorContainer,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
        inverseSurface: AppColors.inverseSurface,
        onInverseSurface: AppColors.inverseOnSurface,
        inversePrimary: AppColors.inversePrimary,
        surfaceTint: AppColors.surfaceTint,
      ),
      textTheme: GoogleFonts.manropeTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: AppColors.onBackground),
          displayMedium: TextStyle(color: AppColors.onBackground),
          displaySmall: TextStyle(color: AppColors.onBackground),
          headlineLarge: TextStyle(color: AppColors.onBackground),
          headlineMedium: TextStyle(color: AppColors.onBackground),
          headlineSmall: TextStyle(color: AppColors.onBackground),
          titleLarge: TextStyle(color: AppColors.onBackground),
          titleMedium: TextStyle(color: AppColors.onBackground),
          titleSmall: TextStyle(color: AppColors.onBackground),
          bodyLarge: TextStyle(color: AppColors.onSurface),
          bodyMedium: TextStyle(color: AppColors.onSurface),
          bodySmall: TextStyle(color: AppColors.onSurface),
          labelLarge: TextStyle(color: AppColors.primary),
          labelMedium: TextStyle(color: AppColors.primary),
          labelSmall: TextStyle(color: AppColors.primary),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceContainer.withOpacity(0.8),
        foregroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.manrope(
          color: AppColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.4,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surfaceContainer.withOpacity(0.8),
        indicatorColor: AppColors.secondary.withOpacity(0.2),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return GoogleFonts.manrope(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          );
        }),
      ),
    );
  }
}
