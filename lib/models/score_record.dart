/// Hasil satu kali kuis yang disimpan ke riwayat.
class ScoreRecord {
  final String playerName;
  final String categoryName;
  final int correct;
  final int wrong;
  final int unanswered;
  final DateTime finishedAt;

  ScoreRecord({
    required this.playerName,
    required this.categoryName,
    required this.correct,
    required this.wrong,
    required this.unanswered,
    required this.finishedAt,
  });

  int get total => correct + wrong + unanswered;
  double get percent => total == 0 ? 0 : correct / total;
}
