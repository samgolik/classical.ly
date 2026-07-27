import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProfileStore extends ChangeNotifier {
  ProfileStore._();
  static final instance = ProfileStore._();

  bool _isComplete = false;
  String _name = '';
  String _instrument = '';

  bool get isComplete => _isComplete;
  String get name => _name;
  String get instrument => _instrument;
  String get initial => _name.isEmpty ? '♪' : _name.substring(0, 1).toUpperCase();

  Future<void> loadForUser(String userId) async {
    _isComplete = false;
    _name = '';
    _instrument = '';
    final snapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final data = snapshot.data();
    if (data != null) {
      _name = data['name'] as String? ?? '';
      _instrument = data['instrument'] as String? ?? '';
      _isComplete = _name.isNotEmpty && _instrument.isNotEmpty;
    }
    notifyListeners();
  }

  Future<void> complete({required String userId, required String name, required String instrument}) async {
    _name = name.trim();
    _instrument = instrument.trim();
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'name': _name,
      'instrument': _instrument,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    _isComplete = true;
    notifyListeners();
  }
}
