enum RepertoireStatus { learning, performed, dream }

class Piece {
  const Piece({
    required this.id,
    required this.title,
    required this.composer,
    required this.subtitle,
    required this.difficulty,
    required this.duration,
    required this.instrumentation,
    this.ensembleType = '',
    this.imslpUrl = 'https://imslp.org',
  });
  final String id, title, composer, subtitle, duration, imslpUrl, ensembleType;
  final double difficulty;
  final List<String> instrumentation;

  factory Piece.fromFirestore(String id, Map<String, dynamic> data) => Piece(
        id: id,
        title: data['title'] as String? ?? '',
        composer: data['composer'] as String? ?? '',
        subtitle: data['subtitle'] as String? ?? '',
        difficulty: (data['difficulty'] as num?)?.toDouble() ?? 0,
        duration: data['duration'] as String? ?? '',
        instrumentation: List<String>.from(data['instrumentation'] as List? ?? const []),
        ensembleType: data['ensembleType'] as String? ?? '',
        imslpUrl: data['imslpUrl'] as String? ?? 'https://imslp.org',
      );
}

class PerformanceLog {
  const PerformanceLog({required this.piece, required this.ensemble, required this.date, required this.role, required this.note, required this.rating});
  final Piece piece;
  final String ensemble, role, note;
  final DateTime date;
  final int rating;
}
