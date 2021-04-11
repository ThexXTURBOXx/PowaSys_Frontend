import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:powasys_frontend/config/config.dart';
import 'package:powasys_frontend/i18n/i18n.dart';
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
    return PowaSysFrontendAppWidget();
  }
}

class PowaSysFrontendAppWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PowaSysFrontendAppWidgetState();
}

class _PowaSysFrontendAppWidgetState extends State<PowaSysFrontendAppWidget> {
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
      title: format(null, 'app_name'),
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeSettings.currentTheme,
      locale: localeSettings.currentLocale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('de'),
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => Home(packageInfo),
      },
    );
  }
}
