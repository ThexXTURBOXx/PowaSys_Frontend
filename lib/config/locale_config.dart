import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:powasys_frontend/i18n/i18n.dart';

class LocaleSettings with ChangeNotifier {
  static String _locale = fallbackLanguage.code;
  final Box _box;

  LocaleSettings(this._box) {
    if (_box.containsKey('locale.current')) {
      _locale = _box.get('locale.current') as String;
    } else {
      _box.put('locale.current', _locale);
    }
  }

  Locale get currentLocale => languages[_locale]!.locale;

  Language? get currentLanguage => languages[_locale];

  String get currentCode => _locale;

  void setLocale(String locale) {
    _locale = locale;
    _box.put('locale.current', _locale);
    notifyListeners();
  }
}
