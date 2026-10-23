/// Model satu soal pilihan ganda.
class Question {
  final int id;
  final String text;
  final List<String> options;

  /// Indeks jawaban yang benar di dalam [options] (dimulai dari 0).
  final int correctIndex;

  /// Pembahasan singkat yang ditampilkan di halaman hasil.
  final String explanation;

  const Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctIndex,
    this.explanation = '',
  }) : assert(correctIndex >= 0);

  String get correctAnswer => options[correctIndex];
}
