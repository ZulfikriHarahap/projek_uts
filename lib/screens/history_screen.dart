import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/utils/responsive.dart';
import '../models/score_record.dart';
import '../providers/score_history_provider.dart';
import '../widgets/score_record_tile.dart';

/// Halaman riwayat skor dan papan skor (leaderboard) dalam dua tab.
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
        content: const Text('Semua riwayat dan papan skor akan dihapus.'),
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
    return DefaultTabController(
      length: 2,
      child: Consumer<ScoreHistoryProvider>(
        builder: (context, history, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Riwayat & Papan Skor'),
              actions: [
                IconButton(
                  tooltip: 'Hapus riwayat',
                  icon: const Icon(Icons.delete_sweep_rounded),
                  onPressed: history.history.isEmpty
                      ? null
                      : () => _confirmClear(context, history),
                ),
              ],
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Riwayat'),
                  Tab(text: 'Papan Skor'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _RecordList(
                  records: history.history,
                  emptyMessage: 'Belum ada riwayat kuis.',
                ),
                _RecordList(
                  records: history.leaderboard,
                  emptyMessage: 'Papan skor masih kosong.',
                  showRank: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Daftar riwayat atau papan skor dengan lebar yang dibatasi di tablet/web.
class _RecordList extends StatelessWidget {
  final List<ScoreRecord> records;
  final String emptyMessage;
  final bool showRank;

  const _RecordList({
    required this.records,
    required this.emptyMessage,
    this.showRank = false,
  });

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(emptyMessage, textAlign: TextAlign.center),
        ),
      );
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: records.length,
          itemBuilder: (context, index) => ScoreRecordTile(
            record: records[index],
            rank: showRank ? index + 1 : null,
          ),
        ),
      ),
    );
  }
}
