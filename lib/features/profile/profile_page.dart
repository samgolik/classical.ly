import 'package:flutter/material.dart';
import '../../data/mock_repository.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import '../piece/piece_detail_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.fromLTRB(20, 24, 20, 32), children: [
    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 72, height: 72, decoration: const BoxDecoration(color: AppTheme.gold, shape: BoxShape.circle), alignment: Alignment.center, child: const Text('S', style: TextStyle(color: AppTheme.ink, fontSize: 30, fontWeight: FontWeight.bold))),
      const SizedBox(width: 16), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Sam', style: Theme.of(context).textTheme.headlineSmall), const Text('Violinist · New York', style: TextStyle(color: AppTheme.muted)), const SizedBox(height: 8), const Wrap(spacing: 6, children: [Pill(label: 'Violin', icon: Icons.music_note_rounded), Pill(label: 'Member since 2026')])]))
    ]),
    const SizedBox(height: 28),
    Card(child: Padding(padding: const EdgeInsets.symmetric(vertical: 17), child: Row(children: const [Expanded(child: _ProfileStat(value: '143', label: 'works played')), Expanded(child: _ProfileStat(value: '67', label: 'concerts')), Expanded(child: _ProfileStat(value: '42', label: 'day streak'))]))),
    const SizedBox(height: 30),
    const SectionTitle('Currently learning'),
    WorkTile(work: MockRepository.sibelius, trailing: const Pill(label: 'In progress'), onTap: () => _open(context, MockRepository.sibelius)),
    const SizedBox(height: 25),
    const SectionTitle('Recently performed', action: 'See all'),
    ...MockRepository.logs.take(3).map((log) => WorkTile(work: log.work, trailing: Text(log.role, style: const TextStyle(color: AppTheme.muted, fontSize: 12)), onTap: () => _open(context, log.work))),
    const SizedBox(height: 25),
    const SectionTitle('Dream repertoire'),
    WorkTile(work: MockRepository.brahms, trailing: const Icon(Icons.bookmark_rounded, color: AppTheme.gold), onTap: () => _open(context, MockRepository.brahms)),
    WorkTile(work: MockRepository.mahler, trailing: const Icon(Icons.bookmark_rounded, color: AppTheme.gold), onTap: () => _open(context, MockRepository.mahler)),
    const SizedBox(height: 25), const SectionTitle('Favorite composers'), const Wrap(spacing: 8, runSpacing: 8, children: [Pill(label: 'Ravel'), Pill(label: 'Mahler'), Pill(label: 'Shostakovich'), Pill(label: 'Saint-Saëns')]),
  ]);
  void _open(BuildContext context, Work work) => Navigator.push(context, MaterialPageRoute(builder: (_) => PieceDetailPage(work: work)));
}
class _ProfileStat extends StatelessWidget { const _ProfileStat({required this.value, required this.label}); final String value, label; @override Widget build(BuildContext context) => Column(children: [Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.gold)), const SizedBox(height: 3), Text(label, style: const TextStyle(color: AppTheme.muted, fontSize: 11))]); }
