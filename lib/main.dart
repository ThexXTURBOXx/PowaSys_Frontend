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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeWidget();
  }
}

class ThemeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ThemeState();
}

class _ThemeState extends State<ThemeWidget> {
  @override
  void initState() {
    super.initState();
    themeSettings.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: format(null, 'app_name'),
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      themeMode: themeSettings.currentTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('de', ''),
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => Home(packageInfo),
      },
    );
  }
}
