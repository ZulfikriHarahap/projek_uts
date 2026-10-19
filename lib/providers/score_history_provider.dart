import 'package:flutter/foundation.dart';

import '../models/score_record.dart';

/// Menyimpan riwayat hasil kuis selama aplikasi berjalan (di memori).
class ScoreHistoryProvider extends ChangeNotifier {
  final List<ScoreRecord> _records = [];

  /// Riwayat dengan yang terbaru di atas.
  List<ScoreRecord> get history => _records.reversed.toList();

  /// Papan skor: skor benar tertinggi di atas. Jika sama, yang selesai lebih dulu di atas.
  List<ScoreRecord> get leaderboard {
    final sorted = List<ScoreRecord>.from(_records);
    sorted.sort((a, b) {
      final byCorrect = b.correct.compareTo(a.correct);
      if (byCorrect != 0) return byCorrect;
      return a.finishedAt.compareTo(b.finishedAt);
    });
    return sorted;
  }

  void add(ScoreRecord record) {
    _records.add(record);
    notifyListeners();
  }

  void clear() {
    _records.clear();
    notifyListeners();
  }
}
