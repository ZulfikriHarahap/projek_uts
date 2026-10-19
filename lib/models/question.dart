/// Model satu soal pilihan ganda.
class Question {
  final int id;
  final String text;
  final List<String> options;

  /// Indeks jawaban yang benar di dalam [options] (dimulai dari 0).
  final int correctIndex;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctIndex,
  }) : assert(correctIndex >= 0 && correctIndex < options.length);

  String get correctAnswer => options[correctIndex];
}
