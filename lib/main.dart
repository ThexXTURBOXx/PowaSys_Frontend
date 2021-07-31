import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:powasys_frontend/config/config.dart';
import 'package:powasys_frontend/generated/l10n.dart';
import 'package:powasys_frontend/pages/home.dart';
import 'package:powasys_frontend/themes/dark_theme.dart';
import 'package:powasys_frontend/themes/light_theme.dart';

late PackageInfo packageInfo;

Future<void> main() async {
  await initConfig();
  packageInfo = await PackageInfo.fromPlatform();
  runApp(PowaSysFrontend());
}

class PowaSysFrontend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PowaSysFrontendWidget();
  }
}

class PowaSysFrontendWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PowaSysFrontendWidgetState();
}

class _PowaSysFrontendWidgetState extends State<PowaSysFrontendWidget> {
  @override
  void initState() {
    super.initState();
    themeSettings.addListener(() {
      setState(() {});
    });
    localeSettings.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => S.of(context).app_name,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeSettings.currentTheme,
      locale: localeSettings.currentLocale,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(packageInfo),
      },
    );
  }
}
