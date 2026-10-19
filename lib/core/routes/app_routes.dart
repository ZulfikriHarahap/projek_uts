import 'package:flutter/material.dart';

import '../../screens/name_input_screen.dart';
import '../../screens/quiz_screen.dart';
import '../../screens/result_screen.dart';

/// Konstanta nama route dan peta route aplikasi.
class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String quiz = '/quiz';
  static const String result = '/result';

  static final Map<String, WidgetBuilder> routes = {
    home: (_) => const NameInputScreen(),
    quiz: (_) => const QuizScreen(),
    result: (_) => const ResultScreen(),
  };
}
