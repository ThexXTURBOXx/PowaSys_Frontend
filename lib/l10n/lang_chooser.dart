import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:powasys_frontend/config/config.dart';

const Language english = Language('en', Locale('en'), 'English', FlagsCode.GB);
const Language german = Language('de', Locale('de'), 'Deutsch', FlagsCode.DE);

const Map<String, Language> languages = {
  'en': english,
  'de': german,
};
const Language fallbackLang = english;

class LanguageChooser extends StatefulWidget {
  const LanguageChooser({super.key});

  @override
  State<StatefulWidget> createState() => LanguageChooserState();
}

class LanguageChooserState extends State<LanguageChooser> {
  @override
  Widget build(BuildContext context) => DropdownButton<Language>(
        value: localeSettings.currentLanguage,
        onChanged: (language) {
          setState(() {
            localeSettings.setLocale((language ?? fallbackLang).code);
          });
        },
        items: languages.values
            .map(
              (lang) => DropdownMenuItem(
                value: lang,
                child: _LanguageItem(lang.flagsCode, lang.name),
              ),
            )
            .toList(),
      );
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
  Widget build(BuildContext context) => Row(
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
