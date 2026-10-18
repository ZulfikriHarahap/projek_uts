import 'package:flutter/foundation.dart';

import '../data/quiz_data.dart';
import '../models/question.dart';

/// Menyimpan seluruh state kuis: nama pemain, soal aktif, jawaban,
/// dan status selesai. Karena berada di atas MaterialApp, state ini
/// tidak hilang saat rotasi layar atau berpindah halaman.
class QuizProvider extends ChangeNotifier {
  QuizProvider({List<Question>? questions})
      : _questions = questions ?? quizQuestions {
    _selectedAnswers = List<int?>.filled(_questions.length, null);
  }

  final List<Question> _questions;
  late List<int?> _selectedAnswers; // jawaban per soal (null = belum dijawab)
  String _playerName = '';
  int _currentIndex = 0;
  bool _isFinished = false;

  // ---------- Getter ----------
  List<Question> get questions => List.unmodifiable(_questions);
  String get playerName => _playerName;
  int get currentIndex => _currentIndex;
  int get totalQuestions => _questions.length;
  Question get currentQuestion => _questions[_currentIndex];
  int? get selectedAnswer => _selectedAnswers[_currentIndex];
  bool get isFirst => _currentIndex == 0;
  bool get isLast => _currentIndex == _questions.length - 1;
  bool get isFinished => _isFinished;

  /// Progres berdasarkan nomor soal yang sedang ditampilkan (0.0 - 1.0).
  double get progress =>
      _questions.isEmpty ? 0 : (_currentIndex + 1) / _questions.length;

  int get unansweredCount => _selectedAnswers.where((a) => a == null).length;
  bool get allAnswered => unansweredCount == 0;

  int get score {
    var total = 0;
    for (var i = 0; i < _questions.length; i++) {
      if (isCorrectAt(i)) total++;
    }
    return total;
  }

  bool isCorrectAt(int index) =>
      _selectedAnswers[index] == _questions[index].correctIndex;

  /// Teks jawaban pemain untuk soal tertentu, atau null jika belum dijawab.
  String? userAnswerTextAt(int index) {
    final selected = _selectedAnswers[index];
    return selected == null ? null : _questions[index].options[selected];
  }

  // ---------- Aksi ----------
  void setPlayerName(String name) {
    _playerName = name.trim();
    notifyListeners();
  }

  void selectAnswer(int optionIndex) {
    if (_isFinished) return;
    _selectedAnswers[_currentIndex] = optionIndex;
    notifyListeners();
  }

  void next() {
    if (isLast) return;
    _currentIndex++;
    notifyListeners();
  }

  void previous() {
    if (isFirst) return;
    _currentIndex--;
    notifyListeners();
  }

  void finish() {
    _isFinished = true;
    notifyListeners();
  }

  /// Mengulang kuis; nama pemain dipertahankan.
  void restart() {
    _selectedAnswers = List<int?>.filled(_questions.length, null);
    _currentIndex = 0;
    _isFinished = false;
    notifyListeners();
  }

  /// Reset total, termasuk nama pemain (dipakai saat kembali ke awal).
  void resetAll() {
    _playerName = '';
    restart();
  }
}
