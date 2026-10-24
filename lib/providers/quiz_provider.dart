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

  /// Progres kuis yang belum selesai, per id kategori.
  final Map<String, _SavedProgress> _saved = {};
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
  /// Memulai kategori. Jika ada progres yang belum selesai, progres itu dilanjutkan.
  void startCategory(QuizCategory category) {
    _category = category;
    final saved = _saved[category.id];
    if (saved != null) {
      _questions = saved.questions;
      _selectedAnswers = List<int?>.from(saved.answers);
      _currentIndex = saved.index;
      _isFinished = false;
    } else {
      _questions = questionsForCategory(category.id);
      _resetProgress();
    }
    notifyListeners();
  }

  /// Kategori yang punya progres belum selesai.
  List<QuizCategory> get unfinishedCategories =>
      _saved.values.map((saved) => saved.category).toList();

  void selectAnswer(int optionIndex) {
    if (_isFinished) return;
    _selectedAnswers[_currentIndex] = optionIndex;
    _persist();
    notifyListeners();
  }

  void next() {
    if (isLast) return;
    _currentIndex++;
    _persist();
    notifyListeners();
  }

  /// Pindah langsung ke nomor soal tertentu (indeks dimulai dari 0).
  void goTo(int index) {
    if (_isFinished || index == _currentIndex) return;
    if (index < 0 || index >= _questions.length) return;
    _currentIndex = index;
    _persist();
    notifyListeners();
  }

  /// True jika soal pada indeks tertentu sudah dijawab.
  bool isAnsweredAt(int index) => _selectedAnswers[index] != null;

  void previous() {
    if (isFirst) return;
    _currentIndex--;
    _persist();
    notifyListeners();
  }

  void finish() {
    _isFinished = true;
    if (_category != null) _saved.remove(_category!.id);
    notifyListeners();
  }

  /// Mengulang kuis; nama pemain dan kategori dipertahankan.
  void restart() {
    if (_category != null) _saved.remove(_category!.id);
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

  /// Menyimpan progres kategori aktif agar bisa dilanjutkan nanti.
  void _persist() {
    final category = _category;
    if (category == null || _isFinished) return;
    _saved[category.id] = _SavedProgress(
      category: category,
      questions: List<Question>.from(_questions),
      answers: List<int?>.from(_selectedAnswers),
      index: _currentIndex,
    );
  }

  void _resetProgress() {
    _selectedAnswers = List<int?>.filled(_questions.length, null);
    _currentIndex = 0;
    _isFinished = false;
  }
}

/// Snapshot progres satu kategori yang belum selesai.
class _SavedProgress {
  final QuizCategory category;
  final List<Question> questions;
  final List<int?> answers;
  final int index;

  _SavedProgress({
    required this.category,
    required this.questions,
    required this.answers,
    required this.index,
  });
}
