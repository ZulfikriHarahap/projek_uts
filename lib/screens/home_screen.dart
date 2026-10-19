import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/routes/app_routes.dart';
import '../core/utils/responsive.dart';
import '../data/quiz_data.dart';
import '../providers/quiz_provider.dart';
import '../widgets/category_card.dart';
import '../widgets/responsive_body.dart';
import '../widgets/theme_toggle_button.dart';

/// Halaman utama: nama aplikasi, info singkat, pilihan kategori,
/// tombol mulai kuis, dan akses ke riwayat.
/// STATEFUL karena menyimpan kategori yang sedang dipilih.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _startQuiz() {
    final category = quizCategories[_selectedIndex];
    // Memulai kategori baru akan mereset progres kuis sebelumnya
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
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                'assets/images/quiz_banner.png',
                height: Responsive.heightFraction(context, 0.22),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: Responsive.heightFraction(context, 0.22),
                  color: scheme.primaryContainer,
                  child: Icon(
                    Icons.quiz_rounded,
                    size: Responsive.scale(context, 72),
                    color: scheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Kuis Pilihan Ganda',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Jawab soal pilihan ganda dan lihat pembahasannya.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
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
                        'Hasil kuis disimpan di riwayat dan papan skor.',
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
            const SizedBox(height: 12),
            for (var i = 0; i < quizCategories.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CategoryCard(
                  category: quizCategories[i],
                  isSelected: _selectedIndex == i,
                  onTap: () => setState(() => _selectedIndex = i),
                ),
              ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _startQuiz,
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Mulai Kuis'),
              style: FilledButton.styleFrom(
                minimumSize: Size.fromHeight(Responsive.scale(context, 54)),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pushNamed(AppRoutes.history),
              icon: const Icon(Icons.leaderboard_rounded),
              label: const Text('Riwayat & Papan Skor'),
              style: OutlinedButton.styleFrom(
                minimumSize: Size.fromHeight(Responsive.scale(context, 52)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
