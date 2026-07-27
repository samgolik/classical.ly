import 'package:flutter/foundation.dart';
import '../models/models.dart';

class RepertoireStore extends ChangeNotifier {
  RepertoireStore._();
  static final instance = RepertoireStore._();

  final List<PerformanceLog> _logs = [];
  List<PerformanceLog> get logs => List.unmodifiable(_logs);
  List<Piece> get pieces {
    final byId = <String, Piece>{};
    for (final log in _logs) {
      byId[log.piece.id] = log.piece;
    }
    return byId.values.toList();
  }

  void addLog(PerformanceLog log) {
    _logs.insert(0, log);
    notifyListeners();
  }
}
