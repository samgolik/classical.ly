import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileStore extends ChangeNotifier {
  ProfileStore._();
  static final instance = ProfileStore._();

  static const _completedKey = 'onboarding_completed';
  static const _nameKey = 'profile_name';
  static const _instrumentKey = 'profile_instrument';

  bool _isComplete = false;
  String _name = '';
  String _instrument = '';

  bool get isComplete => _isComplete;
  String get name => _name;
  String get instrument => _instrument;
  String get initial => _name.isEmpty ? '♪' : _name.substring(0, 1).toUpperCase();

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _isComplete = prefs.getBool(_completedKey) ?? false;
    _name = prefs.getString(_nameKey) ?? '';
    _instrument = prefs.getString(_instrumentKey) ?? '';
    notifyListeners();
  }

  Future<void> complete({required String name, required String instrument}) async {
    _name = name.trim();
    _instrument = instrument.trim();
    _isComplete = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_completedKey, true);
    await prefs.setString(_nameKey, _name);
    await prefs.setString(_instrumentKey, _instrument);
  }
}
