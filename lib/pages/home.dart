import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:powasys_frontend/bloc/cubits/data_cubit.dart';
import 'package:powasys_frontend/constants.dart';
import 'package:powasys_frontend/data/divider_settings.dart';
import 'package:powasys_frontend/data/powa_settings.dart';
import 'package:powasys_frontend/data/trend_diagram.dart';
import 'package:powasys_frontend/data/trend_settings.dart';
import 'package:powasys_frontend/data/trend_table.dart';
import 'package:powasys_frontend/generated/l10n.dart';
import 'package:powasys_frontend/navigation/footer.dart';
import 'package:powasys_frontend/navigation/header.dart';

const routeHome = '/';

class Home extends StatefulWidget {
  final PackageInfo packageInfo;

  const Home(this.packageInfo, {super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<DataCubit>().fetchData(
          disabledPowadors: disabledPowadors,
          currentTrend: currentTrend,
          minDiv: minDiv,
        );
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
          thumbVisibility: true,
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
            context.read<DataCubit>().fetchData(
                  disabledPowadors: disabledPowadors,
                  currentTrend: currentTrend,
                  minDiv: minDiv,
                );
          },
          tooltip: S.of(context).refresh,
          child: const Icon(Icons.refresh),
        ),
      );
}
