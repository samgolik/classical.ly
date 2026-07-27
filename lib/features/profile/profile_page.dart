import 'package:flutter/material.dart';
import '../../data/repertoire_store.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import '../piece/piece_detail_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => ListenableBuilder(listenable: RepertoireStore.instance, builder: (context, _) {
    final logs = RepertoireStore.instance.logs;
    return ListView(padding: const EdgeInsets.fromLTRB(20, 24, 20, 32), children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 72, height: 72, decoration: const BoxDecoration(color: AppTheme.gold, shape: BoxShape.circle), alignment: Alignment.center, child: const Text('S', style: TextStyle(color: AppTheme.ink, fontSize: 30, fontWeight: FontWeight.bold))), const SizedBox(width: 16), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Your profile', style: Theme.of(context).textTheme.headlineSmall), const Text('A living record of your repertoire', style: TextStyle(color: AppTheme.muted)), const SizedBox(height: 8), const Pill(label: 'Musician', icon: Icons.music_note_rounded)]))]),
      const SizedBox(height: 28), Card(child: Padding(padding: const EdgeInsets.symmetric(vertical: 17), child: Row(children: [Expanded(child: _ProfileStat(value: RepertoireStore.instance.works.length.toString(), label: 'works played')), Expanded(child: _ProfileStat(value: logs.length.toString(), label: 'performances')), const Expanded(child: _ProfileStat(value: '—', label: 'day streak'))]))),
      const SizedBox(height: 30), const SectionTitle('Recently performed'),
      if (logs.isEmpty) const Text('Your logged performances will appear here.', style: TextStyle(color: AppTheme.muted)) else ...logs.map((log) => WorkTile(work: log.work, trailing: Text(log.role.isEmpty ? 'Performer' : log.role, style: const TextStyle(color: AppTheme.muted, fontSize: 12)), onTap: () => _open(context, log.work))),
    ];
  });
  void _open(BuildContext context, Work work) => Navigator.push(context, MaterialPageRoute(builder: (_) => PieceDetailPage(work: work)));
}
class _ProfileStat extends StatelessWidget { const _ProfileStat({required this.value, required this.label}); final String value, label; @override Widget build(BuildContext context) => Column(children: [Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.gold)), const SizedBox(height: 3), Text(label, style: const TextStyle(color: AppTheme.muted, fontSize: 11))]); }
