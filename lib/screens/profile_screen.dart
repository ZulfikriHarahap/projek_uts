import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../core/utils/responsive.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/responsive_body.dart';
import '../widgets/theme_toggle_button.dart';
import 'edit_profile_screen.dart';

/// Halaman profil: foto, nama, email, dan instansi.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  /// Memilih foto dari galeri. Hasilnya disimpan sebagai bytes agar
  /// tampil di semua platform (Android, Windows, dan Chrome).
  Future<void> _pickAvatar(BuildContext context) async {
    final profile = context.read<ProfileProvider>();
    final messenger = ScaffoldMessenger.of(context);
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      if (picked == null) return; // pengguna membatalkan pemilihan
      final bytes = await picked.readAsBytes();
      profile.setAvatar(bytes);
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Foto tidak dapat dipilih.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: const [ThemeToggleButton()],
      ),
      body: ResponsiveBody(
        child: Consumer<ProfileProvider>(
          builder: (context, profile, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ProfileAvatar(bytes: profile.avatarBytes, radius: 56),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Material(
                          color: scheme.primary,
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () => _pickAvatar(context),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.camera_alt_rounded,
                                size: 20,
                                color: scheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  profile.name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  profile.email.isEmpty ? 'Email belum diisi' : profile.email,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Card(
                  child: Column(
                    children: [
                      _InfoTile(
                        icon: Icons.mail_outline_rounded,
                        label: 'Email',
                        value: profile.email.isEmpty
                            ? 'Belum diisi'
                            : profile.email,
                      ),
                      const Divider(height: 1),
                      _InfoTile(
                        icon: Icons.school_outlined,
                        label: 'Instansi / Sekolah',
                        value: profile.institution.isEmpty
                            ? 'Belum diisi'
                            : profile.institution,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  icon: const Icon(Icons.edit_rounded),
                  label: const Text('Edit Profil'),
                  style: FilledButton.styleFrom(
                    minimumSize: Size.fromHeight(Responsive.scale(context, 52)),
                  ),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const EditProfileScreen(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(label, style: theme.textTheme.bodySmall),
      subtitle: Text(
        value,
        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
