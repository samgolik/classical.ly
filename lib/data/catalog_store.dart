import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/models.dart';
import 'core_catalog.dart';

class CatalogStore extends ChangeNotifier {
  CatalogStore._();
  static final instance = CatalogStore._();

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _subscription;
  List<Piece> _remotePieces = const [];
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  List<Piece> get pieces {
    final byId = {for (final piece in coreCatalog) piece.id: piece};
    for (final piece in _remotePieces) {
      byId[piece.id] = piece;
    }
    final values = byId.values.toList();
    values.sort((a, b) {
      final composer = a.composer.compareTo(b.composer);
      return composer == 0 ? a.title.compareTo(b.title) : composer;
    });
    return values;
  }

  void start() {
    if (_subscription != null) return;
    _isLoading = true;
    notifyListeners();
    _subscription = FirebaseFirestore.instance.collection('pieces').snapshots().listen(
      (snapshot) {
        _remotePieces = snapshot.docs.map((doc) => Piece.fromFirestore(doc.id, doc.data())).toList();
        _error = null;
        _isLoading = false;
        notifyListeners();
      },
      onError: (_) {
        _error = 'The shared catalog is temporarily unavailable.';
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
