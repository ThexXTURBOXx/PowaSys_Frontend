import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:powasys_frontend/config/config.dart';
import 'package:powasys_frontend/i18n/i18n.dart';

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
          localeSettings.setLocale((language ?? fallbackLanguage).code);
        });
      },
      items: languages.values
          .map(
            (lang) => DropdownMenuItem(
              value: lang,
              child: _LanguageItem(lang.flag, lang.name),
            ),
          )
          .toList(),
    );
  }
}

class _LanguageItem extends StatelessWidget {
  final String flag;
  final String name;

  const _LanguageItem(this.flag, this.name);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Flag(
            flag,
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
