import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

/// Tombol untuk mengganti mode terang/gelap.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDark;

    return IconButton(
      tooltip: isDark ? 'Mode terang' : 'Mode gelap',
      icon: Icon(
        isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
      ),
      onPressed: context.read<ThemeProvider>().toggleTheme,
    );
  }
}
