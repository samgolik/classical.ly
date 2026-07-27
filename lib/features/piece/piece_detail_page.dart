import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import '../log/log_page.dart';

class PieceDetailPage extends StatelessWidget {
  const PieceDetailPage({required this.work, super.key});
  final Work work;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: ListView(padding: const EdgeInsets.fromLTRB(20, 0, 20, 32), children: [
      Text(work.composer.toUpperCase(), style: const TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold, letterSpacing: 1.3)), const SizedBox(height: 7),
      Text(work.title, style: Theme.of(context).textTheme.displaySmall), const SizedBox(height: 6), Text(work.subtitle, style: const TextStyle(color: AppTheme.muted, fontSize: 17)),
      const SizedBox(height: 24),
      Row(children: [Expanded(child: _Stat(value: work.difficulty == 0 ? '—' : work.difficulty.toString(), label: 'difficulty / 10')), Expanded(child: _Stat(value: work.duration.isEmpty ? '—' : work.duration, label: 'duration'))]),
      if (work.instrumentation.isNotEmpty) ...[const SizedBox(height: 28), const SectionTitle('Instrumentation'), Wrap(spacing: 8, runSpacing: 8, children: work.instrumentation.map((i) => Pill(label: i)).toList())],
      const SizedBox(height: 28), const SectionTitle('Resources'),
      Card(child: ListTile(leading: const Icon(Icons.menu_book_rounded, color: AppTheme.gold), title: const Text('Add an IMSLP link'), subtitle: const Text('Save a public-domain score or part link here'), trailing: const Icon(Icons.add_link_rounded), onTap: () => launchUrl(Uri.parse(work.imslpUrl), mode: LaunchMode.externalApplication))),
      const SizedBox(height: 20), const SectionTitle('Recordings'),
      const Card(child: ListTile(leading: Icon(Icons.queue_music_rounded, color: AppTheme.gold, size: 32), title: Text('No recordings added yet'), subtitle: Text('Connect a recording source in a future update.'))),
      const SizedBox(height: 25), FilledButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LogPage(preselected: work))), icon: const Icon(Icons.add_rounded), label: const Text('Log this performance')),
    ]),
  );
}
class _Stat extends StatelessWidget { const _Stat({required this.value, required this.label}); final String value, label; @override Widget build(BuildContext context) => Column(children: [Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.gold)), Text(label, style: const TextStyle(color: AppTheme.muted, fontSize: 11), textAlign: TextAlign.center)]); }
