import 'package:flutter/material.dart';

import '../../screens/history_screen.dart';
import '../../screens/home_screen.dart';
import '../../screens/name_input_screen.dart';
import '../../screens/quiz_screen.dart';
import '../../screens/result_screen.dart';

/// Konstanta nama route dan peta route aplikasi.
class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String name = '/name';
  static const String quiz = '/quiz';
  static const String result = '/result';
  static const String history = '/history';

  static final Map<String, WidgetBuilder> routes = {
    home: (_) => const HomeScreen(),
    name: (_) => const NameInputScreen(),
    quiz: (_) => const QuizScreen(),
    result: (_) => const ResultScreen(),
    history: (_) => const HistoryScreen(),
  };
}
