import 'package:flutter/foundation.dart';

import '../models/score_record.dart';

/// Menyimpan riwayat hasil kuis selama aplikasi berjalan (di memori).
class ScoreHistoryProvider extends ChangeNotifier {
  final List<ScoreRecord> _records = [];

  /// Riwayat dengan yang terbaru di atas.
  List<ScoreRecord> get history => _records.reversed.toList();

  void add(ScoreRecord record) {
    _records.add(record);
    notifyListeners();
  }

  void clear() {
    _records.clear();
    notifyListeners();
  }
}
