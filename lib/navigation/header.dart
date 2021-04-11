import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:powasys_frontend/i18n/i18n.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.psychology_outlined),
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
    return IconButton(
      icon: const Icon(Icons.home_outlined),
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
    return PopupMenuButton<String>(
      onSelected: (d) {
        switch (d) {
          case 'license':
            showLicensePage(
              context: context,
              applicationVersion: packageInfo.version,
              // TODO(Nico): Icon?
              /*applicationIcon: Image.asset(
                        'assets/logo.png',
                        width: 50,
                      ),*/
            );
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 'license',
            child: Text(format(context, 'license')),
          ),
        ];
      },
    );
  }
}
