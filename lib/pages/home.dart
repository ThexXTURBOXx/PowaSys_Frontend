import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:powasys_frontend/config/config.dart';
import 'package:powasys_frontend/data/trend_diagram.dart';
import 'package:powasys_frontend/data/trend_table.dart';
import 'package:powasys_frontend/i18n/i18n.dart';
import 'package:powasys_frontend/navigation/footer.dart';
import 'package:powasys_frontend/navigation/header.dart';

class Home extends StatefulWidget {
  final PackageInfo packageInfo;

  const Home(this.packageInfo);

  @override
  State<StatefulWidget> createState() => _HomeState(packageInfo);
}

class _HomeState extends State<Home> {
  final PackageInfo packageInfo;

  _HomeState(this.packageInfo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Logo(),
        actions: [
          HomeButton(),
          PopMenu(packageInfo),
        ],
      ),
      bottomNavigationBar: Footer(),
      body: Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TrendTable(),
              TrendDiagram(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            themeSettings.setTheme(!themeSettings.isDark);
          });
        },
        tooltip: format(context, 'switch_theme'),
        child: const Icon(Icons.brightness_medium),
      ),
    );
  }
}
