import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';
import '../models/quiz_category.dart';

/// Kartu di beranda untuk melanjutkan kuis yang belum selesai.
class ResumeQuizCard extends StatelessWidget {
  final QuizCategory category;
  final VoidCallback onResume;

  const ResumeQuizCard({super.key, required this.category, required this.onResume});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      color: scheme.secondaryContainer,
      child: Padding(
        padding: EdgeInsets.all(Responsive.scale(context, 16)),
        child: Row(
          children: [
            Icon(Icons.pending_actions_rounded, color: scheme.onSecondaryContainer),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kuis belum selesai',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSecondaryContainer,
                    ),
                  ),
                  Text(
                    category.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: scheme.onSecondaryContainer,
                    ),
                  ),
                ],
              ),
            ),
            FilledButton.tonal(
              onPressed: onResume,
              child: const Text('Lanjutkan'),
            ),
          ],
        ),
      ),
    );
  }
}
