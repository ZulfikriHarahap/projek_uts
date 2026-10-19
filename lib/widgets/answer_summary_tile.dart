import 'package:flutter/material.dart';

/// Baris ringkasan satu soal pada halaman hasil:
/// menampilkan jawaban pemain dan jawaban yang benar.
class AnswerSummaryTile extends StatelessWidget {
  final int number;
  final String question;
  final String? userAnswer;
  final String correctAnswer;
  final bool isCorrect;

  const AnswerSummaryTile({
    super.key,
    required this.number,
    required this.question,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final statusColor = isCorrect ? Colors.green.shade600 : scheme.error;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
              color: statusColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$number. $question',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Jawabanmu: ${userAnswer ?? 'Belum dijawab'}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: statusColor,
                    ),
                  ),
                  if (!isCorrect) ...[
                    const SizedBox(height: 2),
                    Text(
                      'Jawaban benar: $correctAnswer',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
