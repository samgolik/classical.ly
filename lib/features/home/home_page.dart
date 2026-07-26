import 'package:flutter/material.dart';
import '../../data/mock_repository.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import '../piece/piece_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
        children: [
          Row(children: [Text('classical.ly', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppTheme.cream)), const Spacer(), const CircleAvatar(backgroundColor: AppTheme.gold, child: Text('S', style: TextStyle(color: AppTheme.ink, fontWeight: FontWeight.bold)))]),
          const SizedBox(height: 28),
          Text('Your musical life,\nbeautifully remembered.', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 26),
          const SectionTitle('From your circle'),
          ...MockRepository.feed.map((item) => Card(child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PieceDetailPage(work: item.work))),
            child: Padding(padding: const EdgeInsets.all(17), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [CircleAvatar(radius: 17, backgroundColor: AppTheme.cream.withValues(alpha: .12), child: Text(item.name[0])), const SizedBox(width: 10), Expanded(child: RichText(text: TextSpan(style: Theme.of(context).textTheme.bodyMedium, children: [TextSpan(text: item.name, style: const TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: ' ${item.action}')]))), Text(item.when, style: const TextStyle(color: AppTheme.muted, fontSize: 12))]),
              const SizedBox(height: 16), Text(item.work.title, style: Theme.of(context).textTheme.titleLarge), Text('${item.work.composer} · ${item.work.subtitle}', style: const TextStyle(color: AppTheme.muted)),
              const SizedBox(height: 14), Text(item.detail, style: const TextStyle(fontStyle: FontStyle.italic, color: AppTheme.cream)),
            ])),
          ))),
        ],
      );
}
