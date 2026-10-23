import 'dart:math';

import 'package:flutter/material.dart';

import '../models/question.dart';
import '../models/quiz_category.dart';
/// Daftar kategori yang tampil di halaman utama.
const List<QuizCategory> quizCategories = [
  QuizCategory(
    id: 'pemrograman',
    name: 'Pemrograman',
    description: 'Dart, Flutter, dan konsep dasar widget',
    icon: Icons.code_rounded,
    imagePath: 'assets/images/cat_pemrograman.png',
  ),
  QuizCategory(
    id: 'umum',
    name: 'Pengetahuan Umum',
    description: 'Geografi, sains, dan budaya',
    icon: Icons.public_rounded,
    imagePath: 'assets/images/cat_umum.png',
  ),
  QuizCategory(
    id: 'matematika',
    name: 'Matematika',
    description: 'Hitungan dasar dan operasi aritmatika',
    icon: Icons.calculate_rounded,
    imagePath: 'assets/images/cat_matematika.png',
  ),
  QuizCategory(
    id: 'acak',
    name: 'Acak',
    description: 'Campuran soal dari semua kategori',
    icon: Icons.shuffle_rounded,
    imagePath: 'assets/images/cat_acak.png',
  ),
];

/// Soal kategori Pemrograman.
final List<Question> quizQuestions = [
  Question(
    id: 1,
    text: 'Bahasa pemrograman apa yang digunakan untuk membangun aplikasi Flutter?',
    options: ['Java', 'Kotlin', 'Dart', 'Swift'],
    correctIndex: 2,
    explanation: 'Flutter menggunakan bahasa Dart yang dikembangkan oleh Google.',
  ),
  Question(
    id: 2,
    text: 'Widget yang tidak memiliki state internal yang dapat berubah adalah...',
    options: ['StatelessWidget', 'StatefulWidget', 'State', 'BuildContext'],
    correctIndex: 0,
    explanation: 'StatelessWidget tampilannya tetap selama widget ditampilkan.',
  ),
  Question(
    id: 3,
    text: 'Method yang digunakan untuk memberi tahu framework agar membangun ulang UI pada StatefulWidget adalah...',
    options: ['refresh()', 'setState()', 'update()', 'rebuild()'],
    correctIndex: 1,
    explanation: 'setState() memicu build ulang widget setelah data berubah.',
  ),
  Question(
    id: 4,
    text: 'Widget yang tepat untuk menampilkan daftar item yang bisa di-scroll secara efisien adalah...',
    options: ['Column', 'Row', 'ListView', 'Stack'],
    correctIndex: 2,
    explanation: 'ListView hanya membangun item yang terlihat sehingga efisien untuk daftar panjang.',
  ),
  Question(
    id: 5,
    text: 'Package state management yang dibangun di atas InheritedWidget adalah...',
    options: ['provider', 'http', 'path', 'sqflite'],
    correctIndex: 0,
    explanation: 'Provider membungkus InheritedWidget agar lebih mudah dipakai.',
  ),
  Question(
    id: 6,
    text: 'Fungsi yang digunakan untuk menjalankan widget root aplikasi Flutter adalah...',
    options: ['main()', 'build()', 'init()', 'runApp()'],
    correctIndex: 3,
    explanation: 'runApp() menerima widget root dan menjalankannya sebagai aplikasi.',
  ),
  Question(
    id: 7,
    text: 'Layout widget yang menyusun anak-anaknya secara horizontal adalah...',
    options: ['Column', 'Row', 'Stack', 'Wrap'],
    correctIndex: 1,
    explanation: 'Row menyusun anak secara horizontal, sedangkan Column secara vertikal.',
  ),
  Question(
    id: 8,
    text: 'Ekstensi file untuk source code Dart adalah...',
    options: ['.flu', '.fl', '.dart', '.dt'],
    correctIndex: 2,
    explanation: 'File Dart menggunakan ekstensi .dart.',
  ),
  Question(
    id: 9,
    text: 'Widget khusus untuk memberi jarak di sekeliling widget anak adalah...',
    options: ['Padding', 'Spacer', 'Divider', 'Scaffold'],
    correctIndex: 0,
    explanation: 'Padding menambahkan ruang kosong di sekitar widget anak.',
  ),
  Question(
    id: 10,
    text: 'Method yang dipanggil sekali saat State dari StatefulWidget pertama kali dibuat adalah...',
    options: ['build()', 'initState()', 'dispose()', 'setState()'],
    correctIndex: 1,
    explanation: 'initState() dipanggil sekali saat State dibuat, cocok untuk inisialisasi data.',
  ),
];

/// Soal kategori Pengetahuan Umum.
final List<Question> pengetahuanUmumQuestions = [
  Question(
    id: 101,
    text: 'Apa ibu kota Indonesia saat ini?',
    options: ['Bandung', 'Jakarta', 'Surabaya', 'Medan'],
    correctIndex: 1,
    explanation: 'Jakarta adalah ibu kota Indonesia saat ini.',
  ),
  Question(
    id: 102,
    text: 'Planet terbesar di tata surya adalah...',
    options: ['Mars', 'Saturnus', 'Jupiter', 'Venus'],
    correctIndex: 2,
    explanation: 'Jupiter adalah planet terbesar di tata surya.',
  ),
  Question(
    id: 103,
    text: 'Benua dengan luas terbesar di dunia adalah...',
    options: ['Afrika', 'Asia', 'Eropa', 'Amerika Utara'],
    correctIndex: 1,
    explanation: 'Asia adalah benua dengan luas wilayah terbesar.',
  ),
  Question(
    id: 104,
    text: 'Organ tubuh yang berfungsi memompa darah adalah...',
    options: ['Paru-paru', 'Hati', 'Jantung', 'Ginjal'],
    correctIndex: 2,
    explanation: 'Jantung memompa darah ke seluruh tubuh.',
  ),
  Question(
    id: 105,
    text: 'Siapa yang dikenal mengembangkan lampu pijar yang praktis?',
    options: ['Thomas Edison', 'Isaac Newton', 'Albert Einstein', 'Nikola Tesla'],
    correctIndex: 0,
    explanation: 'Thomas Edison dikenal mengembangkan lampu pijar yang praktis untuk digunakan.',
  ),
  Question(
    id: 106,
    text: 'Candi Borobudur terletak di provinsi...',
    options: ['Jawa Barat', 'Jawa Tengah', 'Jawa Timur', 'Bali'],
    correctIndex: 1,
    explanation: 'Candi Borobudur berada di Magelang, Jawa Tengah.',
  ),
  Question(
    id: 107,
    text: 'Bahasa resmi yang digunakan di Brasil adalah...',
    options: ['Spanyol', 'Portugis', 'Inggris', 'Prancis'],
    correctIndex: 1,
    explanation: 'Brasil menggunakan bahasa Portugis sebagai bahasa resminya.',
  ),
  Question(
    id: 108,
    text: 'Gas yang paling banyak terdapat di atmosfer bumi adalah...',
    options: ['Oksigen', 'Karbon dioksida', 'Nitrogen', 'Hidrogen'],
    correctIndex: 2,
    explanation: 'Nitrogen menyusun sekitar 78 persen atmosfer bumi.',
  ),
  Question(
    id: 109,
    text: 'Teks proklamasi kemerdekaan Indonesia dibacakan pada tanggal...',
    options: ['17 Agustus 1945', '28 Oktober 1928', '21 April 1945', '1 Juni 1945'],
    correctIndex: 0,
    explanation: 'Teks proklamasi dibacakan pada 17 Agustus 1945.',
  ),
  Question(
    id: 110,
    text: 'Hewan darat yang dikenal mampu berlari sangat cepat dalam jarak pendek adalah...',
    options: ['Singa', 'Cheetah', 'Kuda', 'Rusa'],
    correctIndex: 1,
    explanation: 'Cheetah dikenal sebagai hewan darat tercepat dalam jarak pendek.',
  ),
];

/// Soal kategori Matematika.
final List<Question> matematikaQuestions = [
  Question(
    id: 201,
    text: 'Berapakah hasil dari 12 x 8?',
    options: ['86', '96', '104', '98'],
    correctIndex: 1,
    explanation: '12 x 8 = 96.',
  ),
  Question(
    id: 202,
    text: 'Berapakah akar kuadrat dari 144?',
    options: ['11', '12', '13', '14'],
    correctIndex: 1,
    explanation: '12 x 12 = 144, sehingga akar kuadratnya 12.',
  ),
  Question(
    id: 203,
    text: 'Jumlah sudut dalam sebuah segitiga adalah...',
    options: ['90 derajat', '180 derajat', '360 derajat', '270 derajat'],
    correctIndex: 1,
    explanation: 'Jumlah sudut dalam segitiga selalu 180 derajat.',
  ),
  Question(
    id: 204,
    text: 'Berapakah nilai dari 2 pangkat 5?',
    options: ['16', '25', '32', '64'],
    correctIndex: 2,
    explanation: '2 x 2 x 2 x 2 x 2 = 32.',
  ),
  Question(
    id: 205,
    text: 'Nilai pi (pi) yang dibulatkan hingga dua angka di belakang koma adalah...',
    options: ['3,14', '2,71', '1,61', '4,20'],
    correctIndex: 0,
    explanation: 'Pi kira-kira 3,14159 sehingga dibulatkan menjadi 3,14.',
  ),
  Question(
    id: 206,
    text: 'Berapakah hasil dari 15 + 3 x 2?',
    options: ['36', '21', '30', '18'],
    correctIndex: 1,
    explanation: 'Perkalian dikerjakan dahulu: 3 x 2 = 6, lalu 15 + 6 = 21.',
  ),
  Question(
    id: 207,
    text: 'Berapakah hasil dari 7 x 9?',
    options: ['63', '56', '72', '81'],
    correctIndex: 0,
    explanation: '7 x 9 = 63.',
  ),
  Question(
    id: 208,
    text: 'Berapakah hasil dari 1/2 + 1/4?',
    options: ['2/6', '3/4', '1/6', '2/4'],
    correctIndex: 1,
    explanation: '1/2 sama dengan 2/4, sehingga 2/4 + 1/4 = 3/4.',
  ),
  Question(
    id: 209,
    text: 'Keliling persegi dengan panjang sisi 5 cm adalah...',
    options: ['10 cm', '20 cm', '25 cm', '15 cm'],
    correctIndex: 1,
    explanation: 'Keliling persegi = 4 x sisi = 4 x 5 = 20 cm.',
  ),
  Question(
    id: 210,
    text: 'Berapakah hasil dari 100 : 4?',
    options: ['20', '25', '40', '15'],
    correctIndex: 1,
    explanation: '100 : 4 = 25.',
  ),
];

/// Mengambil soal sesuai kategori. Setiap kategori berisi 10 soal, Acak mengambil 10 soal dari semua kategori.
List<Question> questionsForCategory(String categoryId) {
  switch (categoryId) {
    case 'umum':
      return List<Question>.from(pengetahuanUmumQuestions);
    case 'matematika':
      return List<Question>.from(matematikaQuestions);
    case 'acak':
      final pool = [
        ...quizQuestions,
        ...pengetahuanUmumQuestions,
        ...matematikaQuestions,
      ]..shuffle(Random());
      return pool.take(10).toList();
    default:
      return List<Question>.from(quizQuestions);
  }
}
