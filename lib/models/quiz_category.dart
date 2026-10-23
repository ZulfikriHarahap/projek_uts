import 'package:flutter/material.dart';

/// Kategori kuis yang dipilih pengguna di halaman utama.
class QuizCategory {
  final String id;
  final String name;
  final String description;
  final IconData icon;

  /// Path ilustrasi kategori di folder assets/images.
  final String imagePath;

  const QuizCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.imagePath,
  });
}
