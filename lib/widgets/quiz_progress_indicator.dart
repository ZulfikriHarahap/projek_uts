import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

/// Indikator progres: teks "Soal x dari y" dan bar persentase.
class QuizProgressIndicator extends StatelessWidget {
  final int current;
  final int total;
  final double progress; // 0.0 - 1.0

  const QuizProgressIndicator({
    super.key,
    required this.current,
    required this.total,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Soal $current dari $total',
                style: theme.textTheme.titleMedium,
              ),
            ),
            Text(
              '${(progress * 100).round()}%',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: scheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: Responsive.scale(context, 10),
            backgroundColor: scheme.surfaceContainerHighest,
            color: scheme.primary,
          ),
        ),
      ],
    );
  }
}
