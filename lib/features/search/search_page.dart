import 'package:flutter/material.dart';
import '../../data/mock_repository.dart';
import '../../models/models.dart';
import '../../widgets/common_widgets.dart';
import '../piece/piece_detail_page.dart';

class SearchPage extends StatefulWidget { const SearchPage({super.key}); @override State<SearchPage> createState() => _SearchPageState(); }
class _SearchPageState extends State<SearchPage> {
  String query = '';
  @override
  Widget build(BuildContext context) {
    final results = MockRepository.works.where((w) => '${w.title} ${w.composer}'.toLowerCase().contains(query.toLowerCase())).toList();
    return Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Discover repertoire', style: Theme.of(context).textTheme.headlineSmall), const SizedBox(height: 18),
      TextField(onChanged: (value) => setState(() => query = value), decoration: const InputDecoration(prefixIcon: Icon(Icons.search_rounded), hintText: 'Search works, composers, instruments')),
      const SizedBox(height: 24), Text(query.isEmpty ? 'Popular this week' : '${results.length} works', style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 8),
      Expanded(child: ListView(children: results.map((Work w) => WorkTile(work: w, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PieceDetailPage(work: w))))).toList())),
    ]));
  }
}
