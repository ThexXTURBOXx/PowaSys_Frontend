import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:powasys_frontend/i18n/i18n.dart';
import 'package:powasys_frontend/i18n/lang_chooser.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BottomAppBar(
      elevation: theme.appBarTheme.elevation,
      color: theme.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(format(context, 'copyright')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LanguageChooser(),
          ),
        ],
      ),
    );
  }
}
