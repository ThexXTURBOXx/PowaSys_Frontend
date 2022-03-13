import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:powasys_frontend/l10n/lang_chooser.dart';

const currentLocaleKey = 'locale.current';

class LocaleSettings extends ChangeNotifier {
  static String _locale = fallbackLang.code;
  final Box _box;

  LocaleSettings(this._box) {
    if (_box.containsKey(currentLocaleKey)) {
      _locale = _box.get(currentLocaleKey) as String;
    } else {
      _box.put(currentLocaleKey, _locale);
    }
  }

  Locale get currentLocale => languages[_locale]!.locale;

  Language? get currentLanguage => languages[_locale];

  String get currentCode => _locale;

  void setLocale(String locale) {
    _locale = locale;
    _box.put(currentLocaleKey, _locale);
    notifyListeners();
  }
}
