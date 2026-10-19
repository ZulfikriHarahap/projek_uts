import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

/// Card untuk menampilkan teks pertanyaan.
class QuestionCard extends StatelessWidget {
  final int number;
  final String question;

  const QuestionCard({
    super.key,
    required this.number,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      color: scheme.primaryContainer,
      child: Padding(
        padding: EdgeInsets.all(Responsive.scale(context, 20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.help_outline_rounded,
                    color: scheme.onPrimaryContainer),
                const SizedBox(width: 8),
                Text(
                  'Pertanyaan $number',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: scheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              question,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: scheme.onPrimaryContainer,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
