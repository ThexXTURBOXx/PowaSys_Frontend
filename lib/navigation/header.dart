import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:powasys_frontend/bloc/cubits/data_cubit.dart';
import 'package:powasys_frontend/bloc/cubits/export_cubit.dart';
import 'package:powasys_frontend/bloc/states.dart';
import 'package:powasys_frontend/config/config.dart';
import 'package:powasys_frontend/data/export.dart';
import 'package:powasys_frontend/generated/l10n.dart';
import 'package:powasys_frontend/pages/home.dart';
import 'package:powasys_frontend/util/navigation.dart';
import 'package:sprintf/sprintf.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) => TextButton.icon(
        icon: const Icon(Icons.code),
        label: Text(S.of(context).app_name),
        onPressed: () => navigateTo(context, routeHome),
      );
}

class HomeButton extends StatelessWidget {
  const HomeButton({super.key});

  @override
  Widget build(BuildContext context) => TextButton.icon(
        icon: const Icon(Icons.home_outlined),
        label: Text(S.of(context).home),
        onPressed: () => navigateTo(context, routeHome),
      );
}

class PopMenu extends StatelessWidget {
  const PopMenu(this.packageInfo, {super.key});

  final PackageInfo packageInfo;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<PackageInfo>('packageInfo', packageInfo));
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<DataCubit, DataState>(
        builder: (context, stateD) => BlocListener<ExportCubit, ExportState>(
          listener: (context, stateE) {
            if (stateE.state.errored) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(S.of(context).exception),
                  content: Text(stateE.ex.toString()),
                ),
              );
            } else if (stateE.state.finished) {
              stateE.toDownload!
                ..setAttribute('download', 'export.csv')
                ..click();
              stateE = stateE.copyWith(toDownload: null); // Save memory
            }
          },
          child: PopupMenuButton<PopupItems>(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context)
                  .textButtonTheme
                  .style!
                  .foregroundColor!
                  .resolve({WidgetState.focused}),
            ),
            onSelected: (d) {
              switch (d) {
                case PopupItems.export:
                  showExportDialog(context, stateD);
                case PopupItems.license:
                  showAboutDialog(
                    context: context,
                    applicationName: S.of(context).app_name,
                    applicationLegalese:
                        sprintf(S.of(context).copyright, [DateTime.now().year]),
                    applicationVersion: packageInfo.version,
                    // TODO(Nico): Icon?
                    /*applicationIcon: Image.asset(
                  'assets/logo.png',
                  width: 50,
                ),*/
                    applicationIcon: const Icon(
                      Icons.code,
                      size: 50,
                    ),
                  );
                case PopupItems.theme:
                  themeSettings.setTheme(isDark: !themeSettings.isDark);
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
          ),
        ),
      );
}

enum PopupItems {
  export(icon: Icons.download),
  theme(icon: Icons.brightness_medium),
  license(icon: Icons.article_outlined);

  const PopupItems({required this.icon});

  final IconData icon;

  String name(BuildContext context) {
    switch (this) {
      case PopupItems.export:
        return S.of(context).export;
      case PopupItems.license:
        return S.of(context).license;
      case PopupItems.theme:
        return S.of(context).switch_theme;
    }
  }
}

class _PopupItem extends StatelessWidget {
  const _PopupItem(this.icon, this.name);

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
                  .resolve({WidgetState.focused}),
            ),
          ),
          Text(
            name,
            textAlign: TextAlign.left,
          ),
        ],
      );
}
