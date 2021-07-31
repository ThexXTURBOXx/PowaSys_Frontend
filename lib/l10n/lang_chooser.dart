import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:powasys_frontend/config/config.dart';

const Language ENGLISH = Language('en', Locale('en'), 'English', FlagsCode.GB);
const Language GERMAN = Language('de', Locale('de'), 'Deutsch', FlagsCode.DE);

const Map<String, Language> LANGUAGES = {
  'en': ENGLISH,
  'de': GERMAN,
};
const Language FALLBACK_LANG = ENGLISH;

class LanguageChooser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LanguageChooserState();
}

class LanguageChooserState extends State<LanguageChooser> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Language>(
      value: localeSettings.currentLanguage,
      onChanged: (language) {
        setState(() {
          localeSettings.setLocale((language ?? FALLBACK_LANG).code);
        });
      },
      items: LANGUAGES.values
          .map(
            (lang) => DropdownMenuItem(
              value: lang,
              child: _LanguageItem(lang.flagsCode, lang.name),
            ),
          )
          .toList(),
    );
  }
}

class Language {
  final String code;
  final Locale locale;
  final String name;
  final FlagsCode flagsCode;

  const Language(this.code, this.locale, this.name, this.flagsCode);
}

class _LanguageItem extends StatelessWidget {
  final FlagsCode flagsCode;
  final String name;

  const _LanguageItem(this.flagsCode, this.name);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Flag.fromCode(
            flagsCode,
            width: 25,
          ),
        ),
        Text(
          name,
          textAlign: TextAlign.left,
        )
      ],
    );
  }
}
