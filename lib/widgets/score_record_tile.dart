import 'package:flutter/material.dart';

import '../models/score_record.dart';

/// Baris satu riwayat atau papan skor.
/// Jika [rank] diisi, lingkaran menampilkan peringkat (untuk papan skor).
class ScoreRecordTile extends StatelessWidget {
  final ScoreRecord record;
  final int? rank;

  const ScoreRecordTile({super.key, required this.record, this.rank});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: scheme.primaryContainer,
              child: rank != null
                  ? Text(
                      '#$rank',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: scheme.onPrimaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  : Icon(
                      Icons.history_rounded,
                      color: scheme.onPrimaryContainer,
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.playerName,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${record.categoryName} - ${formatDate(record.finishedAt)}',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Benar ${record.correct} - Salah ${record.wrong} - Kosong ${record.unanswered}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${record.correct}/${record.total}',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: scheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Format tanggal sederhana: dd/MM/yyyy HH:mm (tanpa package intl).
String formatDate(DateTime date) {
  String two(int n) => n.toString().padLeft(2, '0');
  return '${two(date.day)}/${two(date.month)}/${date.year} '
      '${two(date.hour)}:${two(date.minute)}';
}
