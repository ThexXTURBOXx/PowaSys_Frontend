import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:powasys_frontend/generated/l10n.dart';
import 'package:powasys_frontend/l10n/lang_chooser.dart';
import 'package:sprintf/sprintf.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

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
            child:
                Text(sprintf(S.of(context).copyright, [DateTime.now().year])),
          ),
          Row(
            children: [
              _FooterItem(Icons.subject, S.of(context).imprint),
              _FooterItem(Icons.alternate_email, S.of(context).contact),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: LanguageChooser(),
          ),
        ],
      ),
    );
  }
}

class _FooterItem extends StatelessWidget {
  final IconData icon;
  final String name;

  const _FooterItem(this.icon, this.name);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextButton.icon(
          onPressed: () {},
          icon: Icon(icon),
          label: Text(name),
        ),
      );
}
