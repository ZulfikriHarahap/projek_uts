import 'package:flutter/material.dart';

/// Helper ukuran dinamis berbasis MediaQuery.
/// Semua ukuran dihitung dari layar, bukan angka mati,
/// sehingga UI menyesuaikan HP, tablet, maupun web view.
class Responsive {
  Responsive._();

  /// Lebar referensi (kira-kira lebar layar HP standar).
  static const double _referenceWidth = 375;

  /// Lebar maksimum konten agar tetap rapi di tablet/web.
  static const double maxContentWidth = 640;

  static Size size(BuildContext context) => MediaQuery.sizeOf(context);

  /// True jika perangkat tergolong tablet (sisi terpendek >= 600 dp).
  static bool isTablet(BuildContext context) =>
      size(context).shortestSide >= 600;

  /// Mengskala nilai (font/ikon/tinggi) terhadap lebar layar,
  /// dibatasi antara 85% dan 130% agar tidak terlalu kecil atau besar.
  static double scale(BuildContext context, double value) {
    final factor = size(context).width / _referenceWidth;
    return (value * factor).clamp(value * 0.85, value * 1.3).toDouble();
  }

  /// Tinggi relatif terhadap tinggi layar.
  static double heightFraction(BuildContext context, double fraction) =>
      size(context).height * fraction;

  /// Padding horizontal yang lebih lebar di tablet.
  static EdgeInsets horizontalPadding(BuildContext context) =>
      EdgeInsets.symmetric(horizontal: isTablet(context) ? 32 : 20);
}
