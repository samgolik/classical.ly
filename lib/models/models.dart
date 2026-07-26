enum RepertoireStatus { learning, performed, dream }

class Work {
  const Work({required this.id, required this.title, required this.composer, required this.subtitle, required this.difficulty, required this.duration, required this.instrumentation, this.imslpUrl = 'https://imslp.org'});
  final String id, title, composer, subtitle, duration, imslpUrl;
  final double difficulty;
  final List<String> instrumentation;
}

class PerformanceLog {
  const PerformanceLog({required this.work, required this.ensemble, required this.date, required this.role, required this.note, required this.rating});
  final Work work;
  final String ensemble, role, note;
  final DateTime date;
  final int rating;
}

class FeedItem {
  const FeedItem({required this.name, required this.action, required this.work, required this.detail, required this.when});
  final String name, action, detail, when;
  final Work work;
}
