import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:powasys_frontend/config/config.dart';
import 'package:powasys_frontend/i18n/i18n.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.code),
      label: Text(format(context, 'app_name')),
      onPressed: () {
        if (ModalRoute.of(context)!.settings.name != '/') {
          Navigator.pushReplacementNamed(context, '/');
        }
      },
    );
  }
}

class HomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.home_outlined),
      label: Text(format(context, 'home')),
      onPressed: () {
        if (ModalRoute.of(context)!.settings.name != '/') {
          Navigator.pushReplacementNamed(context, '/');
        }
      },
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
        return [
          PopupMenuItem(
            value: PopupItems.LICENSE,
            child: Text(format(context, 'license')),
          ),
          PopupMenuItem(
            value: PopupItems.THEME,
            child: Text(format(context, 'switch_theme')),
          ),
        ];
      },
    );
  }
}

enum PopupItems {
  LICENSE,
  THEME,
}
