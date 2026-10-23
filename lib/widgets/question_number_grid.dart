import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

/// Daftar nomor soal. Ketuk nomor untuk langsung pindah ke soal itu.
/// Soal yang sudah dijawab diberi warna berbeda dari yang belum dijawab.
class QuestionNumberGrid extends StatelessWidget {
  final int total;
  final int currentIndex;
  final List<bool> answered;
  final ValueChanged<int> onSelect;

  const QuestionNumberGrid({
    super.key,
    required this.total,
    required this.currentIndex,
    required this.answered,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final size = Responsive.scale(context, 40);

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: [
        for (var i = 0; i < total; i++)
          InkWell(
            borderRadius: BorderRadius.circular(Responsive.scale(context, 12)),
            onTap: () => onSelect(i),
            child: Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: answered[i]
                    ? scheme.primaryContainer
                    : scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(Responsive.scale(context, 12)),
                border: Border.all(
                  color: i == currentIndex
                      ? scheme.primary
                      : scheme.outlineVariant,
                  width: i == currentIndex ? 2 : 1,
                ),
              ),
              child: Text(
                '${i + 1}',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: answered[i]
                      ? scheme.onPrimaryContainer
                      : scheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
