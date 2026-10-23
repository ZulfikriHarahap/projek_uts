import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/routes/app_routes.dart';
import '../core/utils/responsive.dart';
import '../data/quiz_data.dart';
import '../models/quiz_category.dart';
import '../providers/quiz_provider.dart';
import '../widgets/resume_quiz_card.dart';
import '../widgets/category_card.dart';
import '../widgets/responsive_body.dart';
import '../widgets/theme_toggle_button.dart';

/// Beranda: banner persegi panjang berisi sapaan, info singkat, dan daftar kategori.
/// Mengetuk kategori membuka halaman input nama.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// Memilih kategori lalu membuka halaman input nama.
  /// Progres kuis sebelumnya direset oleh startCategory.
  /// Melanjutkan kuis yang belum selesai langsung ke halaman kuis.
  void _resumeQuiz(BuildContext context, QuizCategory category) {
    context.read<QuizProvider>().startCategory(category);
    Navigator.of(context).pushNamed(AppRoutes.quiz);
  }

  void _openCategory(BuildContext context, QuizCategory category) {
    context.read<QuizProvider>().startCategory(category);
    Navigator.of(context).pushNamed(AppRoutes.name);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final quiz = context.watch<QuizProvider>();
    final unfinished = quiz.unfinishedCategories;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuis Pilihan Ganda'),
        actions: const [ThemeToggleButton()],
      ),
      body: ResponsiveBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner persegi panjang: gambar, lapisan gelap, dan teks di bawahnya
            ClipRRect(
              borderRadius: BorderRadius.circular(Responsive.scale(context, 20)),
              child: SizedBox(
                height: Responsive.heightFraction(context, 0.22),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/quiz_banner.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: scheme.primaryContainer),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.05),
                            Colors.black.withValues(alpha: 0.65),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(Responsive.scale(context, 18)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Selamat Datang!',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Siap menguji pengetahuanmu hari ini?',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (unfinished.isNotEmpty) ...[
              ResumeQuizCard(
                category: unfinished.last,
                onResume: () => _resumeQuiz(context, unfinished.last),
              ),
              const SizedBox(height: 16),
            ],
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
