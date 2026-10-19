import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/profile_provider.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/responsive_body.dart';

/// Form edit profil. STATEFUL karena memiliki TextEditingController dan GlobalKey form.
/// Hapus foto dilakukan di sini.
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _institutionController;

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileProvider>();
    _nameController = TextEditingController(text: profile.name);
    _emailController = TextEditingController(text: profile.email);
    _institutionController = TextEditingController(text: profile.institution);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _institutionController.dispose();
    super.dispose();
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<ProfileProvider>().updateProfile(
          name: _nameController.text,
          email: _emailController.text,
          institution: _institutionController.text,
        );
    Navigator.of(context).pop();
  }

  InputDecoration _decoration(String label, IconData icon) => InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      );

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: ResponsiveBody(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: ProfileAvatar(bytes: profile.avatarBytes, radius: 48),
              ),
              if (profile.avatarBytes != null) ...[
                const SizedBox(height: 8),
                Center(
                  child: TextButton.icon(
                    onPressed: profile.removeAvatar,
                    icon: const Icon(Icons.delete_outline_rounded),
                    label: const Text('Hapus Foto'),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: _decoration('Nama Lengkap', Icons.person_outline_rounded),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Nama tidak boleh kosong'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _decoration('Email (opsional)', Icons.mail_outline_rounded),
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.isEmpty) return null;
                  return text.contains('@') ? null : 'Format email tidak valid';
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _institutionController,
                textCapitalization: TextCapitalization.words,
                decoration: _decoration('Instansi / Sekolah (opsional)', Icons.school_outlined),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save_rounded),
                label: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
