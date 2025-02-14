import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:powasys_frontend/generated/l10n.dart';
import 'package:sprintf/sprintf.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

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
            child: Text(
              sprintf(S.of(context).copyright, [DateTime.now().year]),
            ),
          ),
          Row(
            children: [
              _FooterItem(Icons.subject, S.of(context).imprint),
              _FooterItem(Icons.alternate_email, S.of(context).contact),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterItem extends StatelessWidget {
  const _FooterItem(this.icon, this.name);

  final IconData icon;
  final String name;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<IconData>('icon', icon))
      ..add(StringProperty('name', name));
  }

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
