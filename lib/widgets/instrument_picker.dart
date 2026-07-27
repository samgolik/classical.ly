import 'package:flutter/material.dart';
import '../data/instruments.dart';
import '../theme/app_theme.dart';

Future<String?> showInstrumentPicker(BuildContext context, {String? selected}) => showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (_) => _InstrumentPicker(selected: selected),
    );

class InstrumentPickerField extends StatelessWidget {
  const InstrumentPickerField({required this.value, required this.onTap, super.key});
  final String value;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        label: 'Primary instrument',
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: InputDecorator(
            decoration: const InputDecoration(labelText: 'Primary instrument'),
            child: Row(children: [
              Expanded(child: Text(value.isEmpty ? 'Choose your instrument' : value, style: TextStyle(color: value.isEmpty ? AppTheme.muted : null))),
              const Icon(Icons.expand_more_rounded, color: AppTheme.gold),
            ]),
          ),
        ),
      );
}

class _InstrumentPicker extends StatefulWidget {
  const _InstrumentPicker({this.selected});
  final String? selected;
  @override
  State<_InstrumentPicker> createState() => _InstrumentPickerState();
}

class _InstrumentPickerState extends State<_InstrumentPicker> {
  String query = '';
  @override
  Widget build(BuildContext context) {
    final normalizedQuery = query.trim().toLowerCase();
    final groups = instrumentGroups.entries
        .map((entry) => MapEntry(entry.key, entry.value.where((instrument) => instrument.toLowerCase().contains(normalizedQuery)).toList()))
        .where((entry) => entry.value.isNotEmpty)
        .toList();
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 12, 20, 20 + MediaQuery.viewInsetsOf(context).bottom),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 38, height: 4, decoration: BoxDecoration(color: AppTheme.cream.withValues(alpha: .2), borderRadius: BorderRadius.circular(8))),
          const SizedBox(height: 20),
          Row(children: [Text('Choose your instrument', style: Theme.of(context).textTheme.titleLarge), const Spacer(), IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded))]),
          const SizedBox(height: 12),
          TextField(onChanged: (value) => setState(() => query = value), autofocus: true, decoration: const InputDecoration(prefixIcon: Icon(Icons.search_rounded), hintText: 'Search instruments')),
          const SizedBox(height: 12),
          Flexible(child: ListView(children: groups.expand((entry) => [
                Padding(padding: const EdgeInsets.fromLTRB(4, 14, 4, 6), child: Text(entry.key.toUpperCase(), style: const TextStyle(color: AppTheme.gold, fontWeight: FontWeight.w700, fontSize: 12, letterSpacing: 1.1))),
                ...entry.value.map((instrument) => ListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      title: Text(instrument),
                      trailing: widget.selected == instrument ? const Icon(Icons.check_rounded, color: AppTheme.gold) : null,
                      onTap: () => Navigator.pop(context, instrument),
                    )),
              ]).toList())),
        ]),
      ),
    );
  }
}
