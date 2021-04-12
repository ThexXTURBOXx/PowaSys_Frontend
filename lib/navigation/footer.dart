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
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(format(context, 'copyright')),
          ),
          Row(
            children: const [
              _FooterItem(Icons.subject, 'imprint'),
              _FooterItem(Icons.alternate_email, 'contact'),
            ],
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

class _FooterItem extends StatelessWidget {
  final IconData icon;
  final String translationKey;

  const _FooterItem(this.icon, this.translationKey);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(icon),
        label: Text(format(context, translationKey)),
      ),
    );
  }
}
