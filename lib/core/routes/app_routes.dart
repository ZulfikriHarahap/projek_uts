import 'package:flutter/material.dart';

import '../../screens/main_shell.dart';
import '../../screens/quiz_screen.dart';
import '../../screens/result_screen.dart';

/// Konstanta nama route dan peta route aplikasi.
/// Halaman utama adalah MainShell (navigasi bawah: Beranda, Riwayat, Profil).
class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String quiz = '/quiz';
  static const String result = '/result';

  static final Map<String, WidgetBuilder> routes = {
    home: (_) => const MainShell(),
    quiz: (_) => const QuizScreen(),
    result: (_) => const ResultScreen(),
  };
}
