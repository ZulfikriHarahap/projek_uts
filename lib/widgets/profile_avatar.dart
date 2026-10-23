import 'dart:typed_data';

import 'package:flutter/material.dart';

/// Avatar profil. Menampilkan foto jika ada, jika tidak ikon default.
class ProfileAvatar extends StatelessWidget {
  final Uint8List? bytes;
  final double radius;

  const ProfileAvatar({super.key, required this.bytes, required this.radius});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return CircleAvatar(
      radius: radius,
      backgroundColor: scheme.primaryContainer,
      backgroundImage: bytes == null ? null : MemoryImage(bytes!),
      child: bytes == null
          ? Icon(
              Icons.person_rounded,
              size: radius,
              color: scheme.onPrimaryContainer,
            )
          : null,
    );
  }
}
