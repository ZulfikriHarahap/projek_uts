import '../models/question.dart';

/// Sumber data soal (dummy/lokal).
/// Semua soal disimpan dalam SATU list, bukan satu file per soal.
/// Untuk menambah soal, cukup tambahkan Question baru di list ini.
final List<Question> quizQuestions = [
  Question(
    id: 1,
    text: 'Bahasa pemrograman apa yang digunakan untuk membangun aplikasi Flutter?',
    options: ['Java', 'Kotlin', 'Dart', 'Swift'],
    correctIndex: 2,
  ),
  Question(
    id: 2,
    text: 'Widget yang tidak memiliki state internal yang dapat berubah adalah...',
    options: ['StatelessWidget', 'StatefulWidget', 'State', 'BuildContext'],
    correctIndex: 0,
  ),
  Question(
    id: 3,
    text: 'Method yang digunakan untuk memberi tahu framework agar membangun ulang UI pada StatefulWidget adalah...',
    options: ['refresh()', 'setState()', 'update()', 'rebuild()'],
    correctIndex: 1,
  ),
  Question(
    id: 4,
    text: 'Widget yang tepat untuk menampilkan daftar item yang bisa di-scroll secara efisien adalah...',
    options: ['Column', 'Row', 'ListView', 'Stack'],
    correctIndex: 2,
  ),
  Question(
    id: 5,
    text: 'Package state management yang dibangun di atas InheritedWidget adalah...',
    options: ['provider', 'http', 'path', 'sqflite'],
    correctIndex: 0,
  ),
  Question(
    id: 6,
    text: 'Fungsi yang digunakan untuk menjalankan widget root aplikasi Flutter adalah...',
    options: ['main()', 'build()', 'init()', 'runApp()'],
    correctIndex: 3,
  ),
  Question(
    id: 7,
    text: 'Layout widget yang menyusun anak-anaknya secara horizontal adalah...',
    options: ['Column', 'Row', 'Stack', 'Wrap'],
    correctIndex: 1,
  ),
  Question(
    id: 8,
    text: 'Ekstensi file untuk source code Dart adalah...',
    options: ['.flu', '.fl', '.dart', '.dt'],
    correctIndex: 2,
  ),
];
