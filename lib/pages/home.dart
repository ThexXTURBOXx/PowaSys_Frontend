import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:powasys_frontend/bloc/blocs/data_bloc.dart';
import 'package:powasys_frontend/bloc/events/data_events.dart';
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
  final DataBloc _bloc = DataBloc();
  final PackageInfo packageInfo;

  _HomeState(this.packageInfo) {
    _bloc.add(FetchData());
  }

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
          _bloc.add(FetchData());
        },
        tooltip: format(context, 'refresh'),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
