import 'package:flutter/foundation.dart';

/// Menyimpan data profil pengguna: nama, email, instansi, dan foto.
/// Data ini dipakai sebagai nama pemain saat memulai kuis.
class ProfileProvider extends ChangeNotifier {
  /// Nama dipakai jika pengguna mengosongkan kolom nama.
  static const String defaultName = 'Pemain';

  // Data dummy awal
  String _name = 'Fikri';
  String _email = 'fikri@gmail.com';
  String _institution = 'Universitas Sumatera Utara';
  Uint8List? _avatarBytes;

  String get name => _name;
  String get email => _email;
  String get institution => _institution;
  Uint8List? get avatarBytes => _avatarBytes;

  void updateProfile({
    required String name,
    required String email,
    required String institution,
  }) {
    final trimmedName = name.trim();
    _name = trimmedName.isEmpty ? defaultName : trimmedName;
    _email = email.trim();
    _institution = institution.trim();
    notifyListeners();
  }

  void setAvatar(Uint8List bytes) {
    _avatarBytes = bytes;
    notifyListeners();
  }

  void removeAvatar() {
    _avatarBytes = null;
    notifyListeners();
  }
}
