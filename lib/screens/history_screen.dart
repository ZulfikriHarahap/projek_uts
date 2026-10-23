import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/utils/responsive.dart';
import '../providers/score_history_provider.dart';
import '../widgets/score_record_tile.dart';
import '../widgets/theme_toggle_button.dart';

/// Halaman riwayat skor kuis (tab navigasi bawah).
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  Future<void> _confirmClear(
    BuildContext context,
    ScoreHistoryProvider history,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus riwayat?'),
        content: const Text('Semua riwayat kuis akan dihapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (confirmed == true) history.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScoreHistoryProvider>(
      builder: (context, history, _) {
        final records = history.history;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Riwayat Skor'),
            actions: [
              IconButton(
                tooltip: 'Hapus riwayat',
                icon: const Icon(Icons.delete_sweep_rounded),
                onPressed: records.isEmpty
                    ? null
                    : () => _confirmClear(context, history),
              ),
              const ThemeToggleButton(),
            ],
          ),
          body: records.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'Belum ada riwayat kuis.\nMulai kuis dari halaman Beranda.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Center(
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: Responsive.maxContentWidth),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: records.length,
                      itemBuilder: (context, index) =>
                          ScoreRecordTile(record: records[index]),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
