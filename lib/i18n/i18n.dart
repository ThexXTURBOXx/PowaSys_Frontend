import 'package:flutter/material.dart';
import 'package:powasys_frontend/i18n/english.dart';
import 'package:powasys_frontend/i18n/german.dart';
import 'package:sprintf/sprintf.dart';

const FALLBACK_LANGUAGE = 'en';

const Map<String, Language> languages = {
  'en': English(),
  'de': German(),
};

final fallback = languages[FALLBACK_LANGUAGE]!;

String format(BuildContext? ctx, dynamic id,
    [List<dynamic> options = const []]) {
  final lang = ctx == null ? fallback : _getCurrentLanguage(ctx) ?? fallback;
  final trans = lang.dict[id] ?? fallback.dict[id]!;
  return sprintf(trans, options);
}

String formatIn(String lang, dynamic id, [List<dynamic> options = const []]) {
  final langObj = _getLanguage(lang) ?? fallback;
  final trans = langObj.dict[id] ?? fallback.dict[id]!;
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

  const Language(this.dict);
}
