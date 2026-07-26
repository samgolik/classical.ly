import '../models/models.dart';

abstract final class MockRepository {
  static const sibelius = Work(id: 'sibelius', title: 'Violin Concerto in D minor', composer: 'Jean Sibelius', subtitle: 'Op. 47', difficulty: 9.4, duration: '32 min', instrumentation: ['Solo violin', '2 flutes', '2 oboes', '2 clarinets', '2 bassoons', 'Horn', 'Orchestra']);
  static const mahler = Work(id: 'mahler5', title: 'Symphony No. 5', composer: 'Gustav Mahler', subtitle: 'C-sharp minor', difficulty: 9.1, duration: '70 min', instrumentation: ['Orchestra', '4 horns', '4 trumpets', 'Timpani', 'Harp', 'Strings']);
  static const mendelssohn = Work(id: 'mendelssohn', title: 'Octet in E-flat major', composer: 'Felix Mendelssohn', subtitle: 'Op. 20', difficulty: 8.2, duration: '32 min', instrumentation: ['4 violins', '2 violas', '2 cellos']);
  static const brahms = Work(id: 'brahms', title: 'Violin Concerto in D major', composer: 'Johannes Brahms', subtitle: 'Op. 77', difficulty: 9.6, duration: '40 min', instrumentation: ['Solo violin', '2 flutes', '2 oboes', '2 clarinets', '2 bassoons', '4 horns', 'Orchestra']);
  static const ravel = Work(id: 'ravel', title: 'Daphnis et Chloé, Suite No. 2', composer: 'Maurice Ravel', subtitle: 'M. 57b', difficulty: 8.7, duration: '16 min', instrumentation: ['Orchestra', 'Flute', 'Harp', 'Percussion', 'Strings']);

  static const works = [sibelius, mahler, mendelssohn, brahms, ravel];
  static const feed = [
    FeedItem(name: 'Sarah Kim', action: 'performed', work: mahler, detail: 'Principal Second Violin · Capital City Symphony', when: '2h'),
    FeedItem(name: 'James Lewis', action: 'started learning', work: sibelius, detail: '“The second movement is pure winter light.”', when: '5h'),
    FeedItem(name: 'Maya Patel', action: 'logged', work: mendelssohn, detail: 'Violin II · First chamber concert of the season.', when: '1d'),
  ];
  static final logs = <PerformanceLog>[
    PerformanceLog(work: ravel, ensemble: 'Arlington Philharmonic', date: DateTime(2026, 6, 14), role: 'Violin I', note: 'That sunrise never gets old.', rating: 5),
    PerformanceLog(work: mendelssohn, ensemble: 'Hearth Chamber Players', date: DateTime(2026, 4, 27), role: 'Violin II', note: 'A joyful, wild ride.', rating: 5),
  ];
}
