import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

/// Card skor akhir dengan lingkaran progres yang beranimasi.
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

    return Card(
      child: Padding(
        padding: EdgeInsets.all(Responsive.scale(context, 24)),
        child: Column(
          children: [
            Text(
              'Selamat, $playerName!',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // TweenAnimationBuilder: animasi tanpa perlu StatefulWidget
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: percent),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutCubic,
              builder: (context, value, _) {
                final size = Responsive.scale(context, 150);
                return SizedBox(
                  width: size,
                  height: size,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: value,
                        strokeWidth: 10,
                        backgroundColor: scheme.surfaceContainerHighest,
                        color: scheme.primary,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$score/$total',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${(value * 100).round()}%',
                            style: theme.textTheme.bodyMedium,
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
              _gradeMessage(percent),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  static String _gradeMessage(double percent) {
    if (percent >= 0.8) return 'Luar biasa! Pemahamanmu sangat baik.';
    if (percent >= 0.5) return 'Bagus! Terus tingkatkan lagi.';
    return 'Jangan menyerah, coba ulangi kuisnya ya.';
  }
}
