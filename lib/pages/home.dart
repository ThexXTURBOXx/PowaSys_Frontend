import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:powasys_frontend/bloc/cubits/data_cubit.dart';
import 'package:powasys_frontend/bloc/states.dart';
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
  const Home(this.packageInfo, {super.key});

  final PackageInfo packageInfo;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<PackageInfo>('packageInfo', packageInfo),
    );
  }

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
      actions: [const HomeButton(), PopMenu(widget.packageInfo)],
    ),
    bottomNavigationBar: const Footer(),
    body: BlocListener<DataCubit, DataState>(
      listener: (context, state) {
        if (state.state.errored) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(S.of(context).exception),
              content: Text(state.ex.toString()),
            ),
          );
        }
      },
      child: const Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          primary: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TrendTable(),
              TrendDiagram(),
              DividerSettings(),
              PowaSettings(),
              TrendSettings(),
            ],
          ),
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
