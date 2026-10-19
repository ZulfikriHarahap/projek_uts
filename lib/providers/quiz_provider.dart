import 'package:flutter/foundation.dart';

import '../data/quiz_data.dart';
import '../models/question.dart';
import '../models/quiz_category.dart';

/// Menyimpan seluruh state kuis: nama pemain, kategori, soal aktif,
/// jawaban, dan status selesai. Karena berada di atas
/// MaterialApp, state ini tidak hilang saat rotasi layar atau pindah halaman.
class QuizProvider extends ChangeNotifier {
  QuizProvider({List<Question>? questions})
      : _questions = questions ?? quizQuestions {
    _selectedAnswers = List<int?>.filled(_questions.length, null);
  }

  List<Question> _questions;
  late List<int?> _selectedAnswers; // jawaban per soal (null = belum dijawab)
  String _playerName = '';
  QuizCategory? _category;
  int _currentIndex = 0;
  bool _isFinished = false;

  // ---------- Getter ----------
  List<Question> get questions => List.unmodifiable(_questions);
  String get playerName => _playerName;
  QuizCategory? get category => _category;
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

  int get correctCount {
    var total = 0;
    for (var i = 0; i < _questions.length; i++) {
      if (isCorrectAt(i)) total++;
    }
    return total;
  }

  int get answeredCount => totalQuestions - unansweredCount;
  int get wrongCount => answeredCount - correctCount;

  /// Skor = jumlah jawaban benar.
  int get score => correctCount;

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

  /// Memulai kuis untuk kategori tertentu dan mereset progres.
  void startCategory(QuizCategory category) {
    _category = category;
    _questions = questionsForCategory(category.id);
    _resetProgress();
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

  /// Mengulang kuis; nama pemain dan kategori dipertahankan.
  void restart() {
    _resetProgress();
    notifyListeners();
  }

  /// Reset total, termasuk nama pemain dan kategori.
  void resetAll() {
    _playerName = '';
    _category = null;
    _resetProgress();
    notifyListeners();
  }

  void _resetProgress() {
    _selectedAnswers = List<int?>.filled(_questions.length, null);
    _currentIndex = 0;
    _isFinished = false;
  }
}
