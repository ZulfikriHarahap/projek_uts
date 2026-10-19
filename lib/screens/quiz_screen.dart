import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/routes/app_routes.dart';
import '../providers/quiz_provider.dart';
import '../widgets/answer_option_button.dart';
import '../widgets/question_card.dart';
import '../widgets/quiz_progress_indicator.dart';
import '../widgets/responsive_body.dart';
import '../widgets/theme_toggle_button.dart';

/// Halaman 2: menampilkan soal dan pilihan jawaban.
/// STATELESS: seluruh state (soal aktif, jawaban terpilih) diambil dari
/// QuizProvider melalui Consumer, sehingga aman dari rotasi layar.
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  void _finishQuiz(BuildContext context, QuizProvider quiz) {
    if (!quiz.allAnswered) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Masih ada ${quiz.unansweredCount} soal yang belum dijawab.',
          ),
        ),
      );
      return;
    }
    quiz.finish();
    // pushReplacement: tombol back tidak kembali ke kuis yang sudah selesai
    Navigator.of(context).pushReplacementNamed(AppRoutes.result);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quiz, _) {
        final question = quiz.currentQuestion;
        final selected = quiz.selectedAnswer;
        final isLast = quiz.isLast;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Halo, ${quiz.playerName}',
              overflow: TextOverflow.ellipsis,
            ),
            actions: const [ThemeToggleButton()],
          ),
          body: ResponsiveBody(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                QuizProgressIndicator(
                  current: quiz.currentIndex + 1,
                  total: quiz.totalQuestions,
                  progress: quiz.progress,
                ),
                const SizedBox(height: 24),
                QuestionCard(
                  number: quiz.currentIndex + 1,
                  question: question.text,
                ),
                const SizedBox(height: 20),
                // Membuat daftar tombol opsi jawaban secara dinamis
                for (var i = 0; i < question.options.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AnswerOptionButton(
                      label: String.fromCharCode('A'.codeUnitAt(0) + i),
                      text: question.options[i],
                      isSelected: selected == i,
                      onTap: () => quiz.selectAnswer(i),
                    ),
                  ),
                const SizedBox(height: 16),
                // Expanded membagi lebar tombol secara adaptif
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: quiz.isFirst ? null : quiz.previous,
                        child: const Text('Sebelumnya'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: isLast
                            ? () => _finishQuiz(context, quiz)
                            : quiz.next,
                        child: Text(isLast ? 'Selesai' : 'Lanjut'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
