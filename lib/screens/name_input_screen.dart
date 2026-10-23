import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/routes/app_routes.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/responsive_body.dart';
import '../widgets/theme_toggle_button.dart';

/// Halaman input nama sebelum kuis dimulai.
/// STATEFUL karena memiliki TextEditingController dan GlobalKey form.
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
    // Isi ulang nama terakhir jika pengguna kembali ke halaman ini
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
    context.read<QuizProvider>().setPlayerName(_nameController.text);
    Navigator.of(context).pushReplacementNamed(AppRoutes.quiz);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Pengguna'),
        actions: const [ThemeToggleButton()],
      ),
      body: ResponsiveBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Responsive.scale(context, 24)),
              child: Image.asset(
                'assets/images/name_banner.png',
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
              'Masukkan Nama Anda',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 28),
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
                  hintText: 'Contoh: Budiono Siregar',
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Responsive.scale(context, 16)),
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
