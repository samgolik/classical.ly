import 'package:flutter/material.dart';
import '../../data/mock_repository.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';

class LogPage extends StatefulWidget { const LogPage({this.preselected, super.key}); final Work? preselected; @override State<LogPage> createState() => _LogPageState(); }
class _LogPageState extends State<LogPage> {
  late Work selected; int rating = 5; final ensemble = TextEditingController(); final role = TextEditingController(); final note = TextEditingController();
  @override void initState() { super.initState(); selected = widget.preselected ?? MockRepository.mahler; }
  @override void dispose() { ensemble.dispose(); role.dispose(); note.dispose(); super.dispose(); }
  void save() { MockRepository.logs.insert(0, PerformanceLog(work: selected, ensemble: ensemble.text.isEmpty ? 'My ensemble' : ensemble.text, date: DateTime.now(), role: role.text.isEmpty ? 'Performer' : role.text, note: note.text, rating: rating)); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Performance added to your repertoire.'))); Navigator.maybePop(context); }
  @override Widget build(BuildContext context) => Scaffold(appBar: widget.preselected != null ? AppBar() : null, body: SafeArea(child: ListView(padding: const EdgeInsets.all(20), children: [
    Text('Log a performance', style: Theme.of(context).textTheme.headlineSmall), const SizedBox(height: 7), const Text('Add this moment to your musical archive.', style: TextStyle(color: AppTheme.muted)), const SizedBox(height: 28),
    const Text('WORK', style: TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold, fontSize: 12)), const SizedBox(height: 7), DropdownButtonFormField<Work>(value: selected, isExpanded: true, items: MockRepository.works.map((w) => DropdownMenuItem(value: w, child: Text('${w.title} — ${w.composer}', overflow: TextOverflow.ellipsis))).toList(), onChanged: (w) => setState(() => selected = w!)),
    const SizedBox(height: 16), TextField(controller: ensemble, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Ensemble or orchestra')), const SizedBox(height: 12), TextField(controller: role, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Part or role (e.g. Violin II)')), const SizedBox(height: 12), TextField(controller: note, minLines: 3, maxLines: 5, decoration: const InputDecoration(labelText: 'Memory or note')), const SizedBox(height: 22),
    const Text('YOUR EXPERIENCE', style: TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold, fontSize: 12)), const SizedBox(height: 7), Row(children: List.generate(5, (i) => IconButton(onPressed: () => setState(() => rating = i + 1), icon: Icon(i < rating ? Icons.star_rounded : Icons.star_outline_rounded, color: AppTheme.gold, size: 31)))), const SizedBox(height: 25), FilledButton(onPressed: save, child: const Text('Save to repertoire')),
  ])));
}
