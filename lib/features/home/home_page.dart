import 'package:flutter/material.dart';
import '../../data/repertoire_store.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import '../piece/piece_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: RepertoireStore.instance,
        builder: (context, _) {
          final logs = RepertoireStore.instance.logs;
          return ListView(padding: const EdgeInsets.fromLTRB(20, 18, 20, 28), children: [
            Row(children: [Text('classical.ly', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppTheme.cream)), const Spacer(), const CircleAvatar(backgroundColor: AppTheme.gold, child: Text('S', style: TextStyle(color: AppTheme.ink, fontWeight: FontWeight.bold)))]),
            const SizedBox(height: 28), Text('Your musical life,\nbeautifully remembered.', style: Theme.of(context).textTheme.displaySmall), const SizedBox(height: 28),
            const SectionTitle('Your recent performances'),
            if (logs.isEmpty) const _EmptyJournal() else ...logs.map((log) => PieceTile(piece: log.piece, trailing: Text(log.role, style: const TextStyle(color: AppTheme.muted, fontSize: 12)), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PieceDetailPage(piece: log.piece))))),
          ]);
        },
      );
}
class _EmptyJournal extends StatelessWidget { const _EmptyJournal(); @override Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Icon(Icons.auto_stories_rounded, color: AppTheme.gold, size: 30), const SizedBox(height: 14), Text('Your journal starts here.', style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 6), const Text('Log your first performance to begin building a living record of the music you play.', style: TextStyle(color: AppTheme.muted))]))); }
