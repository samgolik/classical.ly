import 'package:flutter/material.dart';
import '../../data/catalog_store.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import '../piece/piece_detail_page.dart';

class SearchPage extends StatefulWidget { const SearchPage({super.key}); @override State<SearchPage> createState() => _SearchPageState(); }
class _SearchPageState extends State<SearchPage> {
  String query = '';
  String filter = 'All';
  static const filters = ['All', 'Solo', 'Quartet', 'Chamber', 'Orchestra'];
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: CatalogStore.instance,
    builder: (context, _) {
      final needle = query.trim().toLowerCase();
      final results = CatalogStore.instance.pieces.where((piece) {
        final searchText = '${piece.title} ${piece.composer} ${piece.subtitle} ${piece.ensembleType} ${piece.instrumentation.join(' ')}'.toLowerCase();
        final matchesQuery = needle.isEmpty || searchText.contains(needle);
        final matchesFilter = filter == 'All' || piece.ensembleType == filter || piece.instrumentation.any((force) => force.toLowerCase().contains(filter.toLowerCase()));
        return matchesQuery && matchesFilter;
      }).toList();
      return Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Find a piece', style: Theme.of(context).textTheme.headlineSmall), const SizedBox(height: 6),
        const Text('Search the repertoire catalog, then make it part of your story.', style: TextStyle(color: AppTheme.muted)), const SizedBox(height: 18),
        TextField(onChanged: (value) => setState(() => query = value), textInputAction: TextInputAction.search, decoration: const InputDecoration(prefixIcon: Icon(Icons.search_rounded), hintText: 'Composer, title, opus, or instrumentation')),
        const SizedBox(height: 16),
        SizedBox(height: 38, child: ListView(scrollDirection: Axis.horizontal, children: filters.map((item) => Padding(padding: const EdgeInsets.only(right: 8), child: ChoiceChip(label: Text(item), selected: filter == item, onSelected: (_) => setState(() => filter = item), selectedColor: AppTheme.gold.withValues(alpha: .25)))).toList())),
        const SizedBox(height: 20), Text('${results.length} ${results.length == 1 ? 'piece' : 'pieces'}', style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 8),
        Expanded(child: results.isEmpty ? _NoResults(query: query, filter: filter) : ListView(children: results.map((Piece piece) => PieceTile(piece: piece, trailing: const Icon(Icons.add_circle_outline_rounded, color: AppTheme.gold), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PieceDetailPage(piece: piece))))).toList())),
      ]));
    },
  );
}

class _NoResults extends StatelessWidget {
  const _NoResults({required this.query, required this.filter});
  final String query, filter;
  @override
  Widget build(BuildContext context) => Center(child: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.library_music_outlined, size: 38, color: AppTheme.gold), const SizedBox(height: 14), Text('Nothing quite matches yet.', style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 7), Text(query.isEmpty && filter != 'All' ? 'Try another instrumentation filter.' : 'Try a composer, a shorter title, or another instrumentation.', textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.muted))])));
}
