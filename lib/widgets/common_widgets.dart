import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {this.action, this.onAction, super.key});
  final String title;
  final String? action;
  final VoidCallback? onAction;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(children: [Expanded(child: Text(title, style: Theme.of(context).textTheme.titleLarge)), if (action != null) TextButton(onPressed: onAction, child: Text(action!))]),
      );
}

class WorkTile extends StatelessWidget {
  const WorkTile({required this.work, this.trailing, this.onTap, super.key});
  final Work work;
  final Widget? trailing;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          leading: Container(width: 44, height: 44, decoration: BoxDecoration(color: AppTheme.gold.withValues(alpha: .14), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.music_note_rounded, color: AppTheme.gold)),
          title: Text(work.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700)),
          subtitle: Text('${work.composer} · ${work.subtitle}', maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: trailing ?? const Icon(Icons.chevron_right_rounded),
        ),
      );
}

class Pill extends StatelessWidget {
  const Pill({required this.label, this.icon, super.key});
  final String label;
  final IconData? icon;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(color: AppTheme.card, borderRadius: BorderRadius.circular(100), border: Border.all(color: AppTheme.cream.withValues(alpha: .1))),
        child: Row(mainAxisSize: MainAxisSize.min, children: [if (icon != null) ...[Icon(icon, size: 15, color: AppTheme.gold), const SizedBox(width: 5)], Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600))]),
      );
}
