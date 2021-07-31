import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:powasys_frontend/l10n/lang_chooser.dart';

class LocaleSettings with ChangeNotifier {
  static String _locale = FALLBACK_LANG.code;
  final Box _box;

  LocaleSettings(this._box) {
    if (_box.containsKey('locale.current')) {
      _locale = _box.get('locale.current') as String;
    } else {
      _box.put('locale.current', _locale);
    }
  }

  Locale get currentLocale => LANGUAGES[_locale]!.locale;

  Language? get currentLanguage => LANGUAGES[_locale];

  String get currentCode => _locale;

  void setLocale(String locale) {
    _locale = locale;
    _box.put('locale.current', _locale);
    notifyListeners();
  }
}
