import 'package:flutter/material.dart';
import '../../data/repertoire_store.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';

class LogPage extends StatefulWidget { const LogPage({this.preselected, super.key}); final Piece? preselected; @override State<LogPage> createState() => _LogPageState(); }
class _LogPageState extends State<LogPage> {
  int rating = 5;
  late final title = TextEditingController(text: widget.preselected?.title ?? '');
  late final composer = TextEditingController(text: widget.preselected?.composer ?? '');
  late final subtitle = TextEditingController(text: widget.preselected?.subtitle ?? '');
  final ensemble = TextEditingController(); final role = TextEditingController(); final note = TextEditingController();
  @override void dispose() { title.dispose(); composer.dispose(); subtitle.dispose(); ensemble.dispose(); role.dispose(); note.dispose(); super.dispose(); }
  void save() {
    if (title.text.trim().isEmpty || composer.text.trim().isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add a piece title and composer first.'))); return; }
    final piece = widget.preselected ?? Piece(id: DateTime.now().microsecondsSinceEpoch.toString(), title: title.text.trim(), composer: composer.text.trim(), subtitle: subtitle.text.trim(), difficulty: 0, duration: '', instrumentation: const []);
    RepertoireStore.instance.addLog(PerformanceLog(piece: piece, ensemble: ensemble.text.trim(), date: DateTime.now(), role: role.text.trim(), note: note.text.trim(), rating: rating));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Performance added to your repertoire.'))); Navigator.maybePop(context);
  }
  @override Widget build(BuildContext context) => Scaffold(appBar: widget.preselected != null ? AppBar() : null, body: SafeArea(child: ListView(padding: const EdgeInsets.all(20), children: [
    Text('Log a performance', style: Theme.of(context).textTheme.headlineSmall), const SizedBox(height: 7), const Text('Add this moment to your musical archive.', style: TextStyle(color: AppTheme.muted)), const SizedBox(height: 28),
    const Text('THE PIECE', style: TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold, fontSize: 12)), const SizedBox(height: 7),
    TextField(controller: title, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Piece title *')), const SizedBox(height: 12), TextField(controller: composer, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Composer *')), const SizedBox(height: 12), TextField(controller: subtitle, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Catalogue, key, or opus (optional)')),
    if (widget.preselected != null) ...[const SizedBox(height: 10), Wrap(spacing: 7, runSpacing: 7, children: widget.preselected!.instrumentation.map((item) => Chip(label: Text(item))).toList())],
    const SizedBox(height: 22), const Text('THE PERFORMANCE', style: TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold, fontSize: 12)), const SizedBox(height: 7),
    TextField(controller: ensemble, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Ensemble or orchestra')), const SizedBox(height: 12), TextField(controller: role, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Part or role (e.g. Violin II)')), const SizedBox(height: 12), TextField(controller: note, minLines: 3, maxLines: 5, decoration: const InputDecoration(labelText: 'Memory or note')), const SizedBox(height: 22),
    const Text('YOUR EXPERIENCE', style: TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold, fontSize: 12)), const SizedBox(height: 7), Row(children: List.generate(5, (i) => IconButton(onPressed: () => setState(() => rating = i + 1), icon: Icon(i < rating ? Icons.star_rounded : Icons.star_outline_rounded, color: AppTheme.gold, size: 31)))), const SizedBox(height: 25), FilledButton(onPressed: save, child: const Text('Save to repertoire')),
  ])));
}
