import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/routes/app_routes.dart';
import '../models/score_record.dart';
import '../providers/quiz_provider.dart';
import '../providers/score_history_provider.dart';
import '../widgets/answer_option_button.dart';
import '../widgets/question_card.dart';
import '../widgets/question_number_grid.dart';
import '../widgets/quiz_progress_indicator.dart';
import '../widgets/responsive_body.dart';
import '../widgets/theme_toggle_button.dart';

/// Halaman kuis: soal, opsi jawaban, dan progres.
/// STATELESS: seluruh state diambil dari QuizProvider melalui Consumer.
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  /// Menyelesaikan kuis, menyimpan ke riwayat, lalu membuka halaman hasil.
  void _finalize(BuildContext context, QuizProvider quiz) {
    if (quiz.isFinished) return; // cegah penyimpanan ganda
    quiz.finish();
    context.read<ScoreHistoryProvider>().add(
          ScoreRecord(
            playerName: quiz.playerName,
            categoryName: quiz.category?.name ?? 'Umum',
            correct: quiz.correctCount,
            wrong: quiz.wrongCount,
            finishedAt: DateTime.now(),
          ),
        );
    Navigator.of(context).pushReplacementNamed(AppRoutes.result);
  }

  /// Tombol Selesai ditekan: semua soal harus sudah dijawab.
  void _onFinishPressed(BuildContext context, QuizProvider quiz) {
    if (!quiz.allAnswered) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Jawab semua soal terlebih dahulu. Sisa ${quiz.unansweredCount} soal.',
          ),
        ),
      );
      return;
    }
    _finalize(context, quiz);
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
                const SizedBox(height: 16),
                QuestionNumberGrid(
                  total: quiz.totalQuestions,
                  currentIndex: quiz.currentIndex,
                  answered: List<bool>.generate(
                    quiz.totalQuestions,
                    quiz.isAnsweredAt,
                  ),
                  onSelect: quiz.goTo,
                ),
                const SizedBox(height: 24),
                QuestionCard(
                  number: quiz.currentIndex + 1,
                  question: question.text,
                ),
                const SizedBox(height: 20),
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
                            ? () => _onFinishPressed(context, quiz)
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