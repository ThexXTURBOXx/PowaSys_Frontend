import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:powasys_frontend/bloc/blocs/data_bloc.dart';
import 'package:powasys_frontend/bloc/events.dart';
import 'package:powasys_frontend/data/divider_settings.dart';
import 'package:powasys_frontend/data/powa_settings.dart';
import 'package:powasys_frontend/data/trend_diagram.dart';
import 'package:powasys_frontend/data/trend_settings.dart';
import 'package:powasys_frontend/data/trend_table.dart';
import 'package:powasys_frontend/generated/l10n.dart';
import 'package:powasys_frontend/navigation/footer.dart';
import 'package:powasys_frontend/navigation/header.dart';

class Home extends StatefulWidget {
  final PackageInfo packageInfo;

  const Home(this.packageInfo, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DataBloc _bloc = DataBloc();

  _HomeState() {
    _bloc.add(const FetchData());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Logo(),
          actions: [
            const HomeButton(),
            PopMenu(widget.packageInfo),
          ],
        ),
        bottomNavigationBar: const Footer(),
        body: Scrollbar(
          isAlwaysShown: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                TrendTable(),
                TrendDiagram(),
                DividerSettings(),
                PowaSettings(),
                TrendSettings(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _bloc.add(const FetchData());
          },
          tooltip: S.of(context).refresh,
          child: const Icon(Icons.refresh),
        ),
      );
}
