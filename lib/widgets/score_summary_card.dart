import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

/// Kartu skor akhir: persentase besar dalam lingkaran, jumlah benar,
/// label predikat, dan pesan. Lingkaran beranimasi saat halaman dibuka.
class ScoreSummaryCard extends StatelessWidget {
  final String playerName;
  final int score;
  final int total;

  const ScoreSummaryCard({
    super.key,
    required this.playerName,
    required this.score,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final percent = total == 0 ? 0.0 : score / total;
    final grade = _grade(percent, scheme);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(Responsive.scale(context, 24)),
        child: Column(
          children: [
            Text(
              'Hasil untuk $playerName',
              style: theme.textTheme.titleMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: percent),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              builder: (context, value, _) {
                final size = Responsive.scale(context, 160);
                return SizedBox(
                  width: size,
                  height: size,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox.expand(
                        child: CircularProgressIndicator(
                          value: value,
                          strokeWidth: 12,
                          backgroundColor: scheme.surfaceContainerHighest,
                          color: grade.color,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${(value * 100).round()}%',
                            style: theme.textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'nilai',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              '$score dari $total jawaban benar',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: grade.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                grade.label,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: grade.color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              grade.message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  static _Grade _grade(double percent, ColorScheme scheme) {
    if (percent >= 0.8) {
      return _Grade(
        label: 'Luar Biasa',
        message: 'Pemahamanmu sangat baik. Pertahankan!',
        color: Colors.green.shade700,
      );
    }
    if (percent >= 0.5) {
      return _Grade(
        label: 'Bagus',
        message: 'Sudah cukup baik. Pelajari lagi jawaban yang salah.',
        color: scheme.primary,
      );
    }
    return _Grade(
      label: 'Perlu Latihan',
      message: 'Baca kembali pembahasan, lalu coba ulangi kuisnya.',
      color: scheme.error,
    );
  }
}

class _Grade {
  final String label;
  final String message;
  final Color color;

  const _Grade({required this.label, required this.message, required this.color});
}
