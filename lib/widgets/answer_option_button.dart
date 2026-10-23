import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

/// Tombol pilihan jawaban (A, B, C, D). Stateless: status dipilih
/// dikirim dari luar (provider), bukan disimpan di widget ini.
class AnswerOptionButton extends StatelessWidget {
  final String label;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const AnswerOptionButton({
    super.key,
    required this.label,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final borderColor = isSelected ? scheme.primary : scheme.outlineVariant;
    final backgroundColor =
        isSelected ? scheme.primaryContainer : scheme.surface;
    final foregroundColor =
        isSelected ? scheme.onPrimaryContainer : scheme.onSurface;

    return Semantics(
      button: true,
      selected: isSelected,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(Responsive.scale(context, 16)),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(Responsive.scale(context, 16)),
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.scale(context, 16),
                vertical: Responsive.scale(context, 14),
              ),
              child: Row(
                children: [
                  Container(
                    width: Responsive.scale(context, 34),
                    height: Responsive.scale(context, 34),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? scheme.primary
                          : scheme.surfaceContainerHighest,
                    ),
                    child: Text(
                      label,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? scheme.onPrimary
                            : scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Expanded agar teks panjang otomatis turun baris
                  Expanded(
                    child: Text(
                      text,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: foregroundColor,
                      ),
                    ),
                  ),
                  if (isSelected) ...[
                    const SizedBox(width: 8),
                    Icon(Icons.check_circle_rounded, color: scheme.primary),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
