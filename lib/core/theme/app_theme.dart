import 'package:flutter/material.dart';

/// Konfigurasi tema terang dan gelap (dual theme).
/// Warna dibuat dari satu seed sehingga konsisten di kedua mode.
class AppTheme {
  AppTheme._();

  static const Color _seedColor = Color(0xFF6C5CE7);

  static ThemeData light() => _buildTheme(Brightness.light);
  static ThemeData dark() => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: brightness,
    );
    final base = ThemeData(useMaterial3: true, colorScheme: colorScheme);

    // Terapkan font Poppins (aset lokal) ke seluruh teks aplikasi
    final textTheme = base.textTheme.apply(fontFamily: 'Poppins');

    return base.copyWith(
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }
}
