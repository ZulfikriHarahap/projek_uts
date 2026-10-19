import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';
import '../models/quiz_category.dart';

/// Kartu kategori kuis. Ketuk kartu untuk langsung memulai kuis.
class CategoryCard extends StatelessWidget {
  final QuizCategory category;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(Responsive.scale(context, 16)),
          child: Row(
            children: [
              Icon(
                category.icon,
                size: Responsive.scale(context, 32),
                color: scheme.primary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category.description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.play_circle_fill_rounded, color: scheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}
