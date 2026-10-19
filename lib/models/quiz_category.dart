import 'package:flutter/material.dart';

/// Kategori kuis yang dipilih pengguna di halaman utama.
class QuizCategory {
  final String id;
  final String name;
  final String description;
  final IconData icon;

  const QuizCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });
}
