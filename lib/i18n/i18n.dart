import 'package:flutter/material.dart';
import 'package:powasys_frontend/i18n/english.dart';
import 'package:powasys_frontend/i18n/german.dart';
import 'package:sprintf/sprintf.dart';

const FALLBACK_LANGUAGE = English.CODE;

const Map<String, Language> languages = {
  English.CODE: English(),
  German.CODE: German(),
};

final fallbackLanguage = languages[FALLBACK_LANGUAGE]!;

String format(BuildContext? ctx, dynamic id,
    [List<dynamic> options = const []]) {
  final lang = ctx == null
      ? fallbackLanguage
      : _getCurrentLanguage(ctx) ?? fallbackLanguage;
  final trans = lang.dict[id] ?? fallbackLanguage.dict[id]!;
  return sprintf(trans, options);
}

String formatIn(String lang, dynamic id, [List<dynamic> options = const []]) {
  final langObj = _getLanguage(lang) ?? fallbackLanguage;
  final trans = langObj.dict[id] ?? fallbackLanguage.dict[id]!;
  return sprintf(trans, options);
}

Language? _getCurrentLanguage(BuildContext ctx) {
  return _getLanguage(Localizations.localeOf(ctx).languageCode);
}

Language? _getLanguage(String id) {
  return languages[id];
}

class Language {
  final Map<dynamic, String> dict;
  final String code;
  final Locale locale;
  final String name;
  final String flag;

  const Language(this.dict, this.code, this.locale, this.name, this.flag);
}
