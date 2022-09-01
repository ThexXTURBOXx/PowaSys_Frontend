import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeSettings extends ChangeNotifier {
  static bool _isDark = false;
  final Box _box;

  ThemeSettings(this._box) {
    if (_box.containsKey('theme.dark')) {
      _isDark = _box.get('theme.dark') as bool;
    } else {
      _box.put('theme.dark', _isDark);
    }
  }

  ThemeMode get currentTheme => _isDark ? ThemeMode.dark : ThemeMode.light;

  bool get isDark => _isDark;

  void setTheme({required bool isDark}) {
    _isDark = isDark;
    _box.put('theme.dark', _isDark);
    notifyListeners();
  }
}
