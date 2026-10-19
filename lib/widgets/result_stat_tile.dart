import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

/// Kotak statistik hasil kuis (benar, salah, kosong).
/// Pemakaian: bungkus dengan Expanded di dalam Row.
class ResultStatTile extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;
  final Color color;

  const ResultStatTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Responsive.scale(context, 14),
          horizontal: 8,
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 6),
            Text(
              '$value',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(label, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
