import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:powasys_frontend/config/config.dart';
import 'package:powasys_frontend/i18n/i18n.dart';
import 'package:powasys_frontend/util/navigation.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.code),
      label: Text(format(context, 'app_name')),
      onPressed: () => navigateTo(context, '/'),
    );
  }
}

class HomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.home_outlined),
      label: Text(format(context, 'home')),
      onPressed: () => navigateTo(context, '/'),
    );
  }
}

class PopMenu extends StatelessWidget {
  final PackageInfo packageInfo;

  const PopMenu(this.packageInfo);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopupItems>(
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context)
            .textButtonTheme
            .style!
            .foregroundColor!
            .resolve({MaterialState.focused})!,
      ),
      onSelected: (d) {
        switch (d) {
          case PopupItems.LICENSE:
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
          case PopupItems.THEME:
            themeSettings.setTheme(!themeSettings.isDark);
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return PopupItems.values
            .map(
              (item) => PopupMenuItem(
                value: item,
                child: _PopupItem(item.icon, item.translationKey),
              ),
            )
            .toList();
      },
    );
  }
}

enum PopupItems {
  LICENSE,
  THEME,
}

extension PopupItemsMeta on PopupItems {
  IconData get icon {
    switch (this) {
      case PopupItems.LICENSE:
        return Icons.article_outlined;
      case PopupItems.THEME:
        return Icons.brightness_medium;
    }
  }

  String get translationKey {
    switch (this) {
      case PopupItems.LICENSE:
        return 'license';
      case PopupItems.THEME:
        return 'switch_theme';
    }
  }
}

class _PopupItem extends StatelessWidget {
  final IconData icon;
  final String translationKey;

  const _PopupItem(this.icon, this.translationKey);

  @override
  Widget build(BuildContext context) {
    return Row(
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
                .resolve({MaterialState.focused})!,
          ),
        ),
        Text(
          format(context, translationKey),
          textAlign: TextAlign.left,
        )
      ],
    );
  }
}
