import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/routes/app_routes.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/responsive_body.dart';
import '../widgets/theme_toggle_button.dart';

/// Halaman 1: input nama pemain.
/// STATEFUL karena memiliki TextEditingController & GlobalKey form
/// yang harus dibuat dan dibuang (dispose) sesuai siklus hidup widget.
class NameInputScreen extends StatefulWidget {
  const NameInputScreen({super.key});

  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    // Isi ulang nama jika pemain kembali ke halaman ini
    _nameController = TextEditingController(
      text: context.read<QuizProvider>().playerName,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final quiz = context.read<QuizProvider>();
    quiz.setPlayerName(_nameController.text);
    // Jika kuis sebelumnya sudah selesai, mulai ulang dari awal
    if (quiz.isFinished) quiz.restart();

    Navigator.of(context).pushNamed(AppRoutes.quiz);
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
            // Banner gambar dengan fallback jika aset gagal dimuat
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                'assets/images/quiz_banner.png',
                height: Responsive.heightFraction(context, 0.25),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: Responsive.heightFraction(context, 0.25),
                  color: scheme.primaryContainer,
                  child: Icon(
                    Icons.quiz_rounded,
                    size: Responsive.scale(context, 72),
                    color: scheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Selamat Datang!',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Masukkan namamu, lalu jawab setiap soal dengan teliti.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _nameController,
                maxLength: 20,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _startQuiz(),
                decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  hintText: 'Contoh: Budi Santoso',
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                validator: (value) {
                  final name = value?.trim() ?? '';
                  if (name.isEmpty) return 'Nama tidak boleh kosong';
                  if (name.length < 3) return 'Nama minimal 3 karakter';
                  return null;
                },
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _startQuiz,
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Mulai Kuis'),
              style: FilledButton.styleFrom(
                minimumSize: Size.fromHeight(Responsive.scale(context, 54)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
