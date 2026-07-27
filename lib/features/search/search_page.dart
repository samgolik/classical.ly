import 'package:flutter/material.dart';
import '../../data/repertoire_store.dart';
import '../../models/models.dart';
import '../../widgets/common_widgets.dart';
import '../piece/piece_detail_page.dart';

class SearchPage extends StatefulWidget { const SearchPage({super.key}); @override State<SearchPage> createState() => _SearchPageState(); }
class _SearchPageState extends State<SearchPage> {
  String query = '';
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: RepertoireStore.instance,
    builder: (context, _) {
      final results = RepertoireStore.instance.pieces.where((p) => '${p.title} ${p.composer}'.toLowerCase().contains(query.toLowerCase())).toList();
      return Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Your repertoire', style: Theme.of(context).textTheme.headlineSmall), const SizedBox(height: 18),
        TextField(onChanged: (value) => setState(() => query = value), decoration: const InputDecoration(prefixIcon: Icon(Icons.search_rounded), hintText: 'Search your logged pieces')),
        const SizedBox(height: 24), Text(query.isEmpty ? 'Logged pieces' : '${results.length} pieces', style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 8),
        Expanded(child: results.isEmpty ? const Center(child: Text('No pieces yet. Log a performance to add one.', textAlign: TextAlign.center)) : ListView(children: results.map((Piece piece) => PieceTile(piece: piece, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PieceDetailPage(piece: piece))))).toList())),
      ]));
    },
  );
}
