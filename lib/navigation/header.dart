import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:powasys_frontend/config/config.dart';
import 'package:powasys_frontend/generated/l10n.dart';
import 'package:powasys_frontend/util/navigation.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => TextButton.icon(
        icon: const Icon(Icons.code),
        label: Text(S.of(context).app_name),
        onPressed: () => navigateTo(context, '/'),
      );
}

class HomeButton extends StatelessWidget {
  const HomeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => TextButton.icon(
        icon: const Icon(Icons.home_outlined),
        label: Text(S.of(context).home),
        onPressed: () => navigateTo(context, '/'),
      );
}

class PopMenu extends StatelessWidget {
  final PackageInfo packageInfo;

  const PopMenu(this.packageInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => PopupMenuButton<PopupItems>(
        icon: Icon(
          Icons.more_vert,
          color: Theme.of(context)
              .textButtonTheme
              .style!
              .foregroundColor!
              .resolve({MaterialState.focused}),
        ),
        onSelected: (d) {
          switch (d) {
            case PopupItems.license:
              showLicensePage(
                context: context,
                applicationVersion: packageInfo.version,
                // TODO(Nico): Icon?
                applicationIcon: const Icon(
                  Icons.code,
                  size: 50,
                ),
                /*applicationIcon: Image.asset(
                        'assets/logo.png',
                        width: 50,
                      ),*/
              );
              break;
            case PopupItems.theme:
              themeSettings.setTheme(isDark: !themeSettings.isDark);
              break;
          }
        },
        itemBuilder: (context) => PopupItems.values
            .map(
              (item) => PopupMenuItem(
                value: item,
                child: _PopupItem(item.icon, item.name(context)),
              ),
            )
            .toList(),
      );
}

enum PopupItems {
  license,
  theme,
}

extension PopupItemsMeta on PopupItems {
  IconData get icon {
    switch (this) {
      case PopupItems.license:
        return Icons.article_outlined;
      case PopupItems.theme:
        return Icons.brightness_medium;
    }
  }

  String name(BuildContext context) {
    switch (this) {
      case PopupItems.license:
        return S.of(context).license;
      case PopupItems.theme:
        return S.of(context).switch_theme;
    }
  }
}

class _PopupItem extends StatelessWidget {
  final IconData icon;
  final String name;

  const _PopupItem(this.icon, this.name);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              icon,
              size: 25,
              color: Theme.of(context)
                  .textButtonTheme
                  .style!
                  .foregroundColor!
                  .resolve({MaterialState.focused}),
            ),
          ),
          Text(
            name,
            textAlign: TextAlign.left,
          )
        ],
      );
}
