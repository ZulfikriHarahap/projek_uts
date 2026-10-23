import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/routes/app_routes.dart';
import '../core/utils/responsive.dart';
import '../data/quiz_data.dart';
import '../models/quiz_category.dart';
import '../providers/quiz_provider.dart';
import '../widgets/category_card.dart';
import '../widgets/responsive_body.dart';
import '../widgets/theme_toggle_button.dart';

/// Beranda: sapaan pengguna, info singkat, dan daftar kategori.
/// Mengetuk kategori langsung memulai kuis dengan nama pemain default.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// Memilih kategori lalu membuka halaman input nama.
  /// Progres kuis sebelumnya direset oleh startCategory.
  void _openCategory(BuildContext context, QuizCategory category) {
    context.read<QuizProvider>().startCategory(category);
    Navigator.of(context).pushNamed(AppRoutes.name);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuis Pilihan Ganda'),
        actions: const [ThemeToggleButton()],
      ),
      body: ResponsiveBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Selamat datang!',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Siap menguji pengetahuanmu hari ini?',
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                'assets/images/quiz_banner.png',
                height: Responsive.heightFraction(context, 0.2),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: Responsive.heightFraction(context, 0.2),
                  color: scheme.primaryContainer,
                  child: Icon(
                    Icons.quiz_rounded,
                    size: Responsive.scale(context, 72),
                    color: scheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.info_outline_rounded, color: scheme.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Jawab setiap soal dengan memilih salah satu opsi. '
                        'Hasil kuis tersimpan di Riwayat.',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Pilih Kategori',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Pilih kategori, lalu masukkan namamu untuk memulai.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            for (final category in quizCategories)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CategoryCard(
                  category: category,
                  onTap: () => _openCategory(context, category),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
