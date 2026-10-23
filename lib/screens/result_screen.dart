import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/routes/app_routes.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/answer_summary_tile.dart';
import '../widgets/responsive_body.dart';
import '../widgets/result_stat_tile.dart';
import '../widgets/score_summary_card.dart';
import '../widgets/theme_toggle_button.dart';

/// Halaman hasil: skor, jumlah benar/salah/kosong, dan pembahasan.
/// STATELESS: data dibaca dari QuizProvider.
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quiz, _) {
        final theme = Theme.of(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Hasil Kuis'),
            automaticallyImplyLeading: false,
            actions: const [ThemeToggleButton()],
          ),
          body: ResponsiveBody(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/icons/trophy.png',
                  height: Responsive.scale(context, 96),
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.emoji_events_rounded,
                    size: Responsive.scale(context, 96),
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(height: 16),
                ScoreSummaryCard(
                  playerName: quiz.playerName,
                  score: quiz.score,
                  total: quiz.totalQuestions,
                ),
                const SizedBox(height: 12),
                Text(
                  'Kategori: ${quiz.category?.name ?? '-'}',
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ResultStatTile(
                        label: 'Benar',
                        value: quiz.correctCount,
                        icon: Icons.check_circle_rounded,
                        color: Colors.green.shade600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ResultStatTile(
                        label: 'Salah',
                        value: quiz.wrongCount,
                        icon: Icons.cancel_rounded,
                        color: theme.colorScheme.error,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ResultStatTile(
                        label: 'Kosong',
                        value: quiz.unansweredCount,
                        icon: Icons.remove_circle_outline_rounded,
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Text(
                  'Ringkasan & Pembahasan',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                for (var i = 0; i < quiz.questions.length; i++)
                  AnswerSummaryTile(
                    number: i + 1,
                    question: quiz.questions[i].text,
                    userAnswer: quiz.userAnswerTextAt(i),
                    correctAnswer: quiz.questions[i].correctAnswer,
                    isCorrect: quiz.isCorrectAt(i),
                    explanation: quiz.questions[i].explanation,
                  ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Ulangi Kuis'),
                  style: FilledButton.styleFrom(
                    minimumSize: Size.fromHeight(Responsive.scale(context, 52)),
                  ),
                  onPressed: () {
                    quiz.restart();
                    Navigator.of(context).pushReplacementNamed(AppRoutes.quiz);
                  },
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  icon: const Icon(Icons.home_rounded),
                  label: const Text('Kembali ke Awal'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.fromHeight(Responsive.scale(context, 52)),
                  ),
                  onPressed: () {
                    quiz.resetAll();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.home,
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
