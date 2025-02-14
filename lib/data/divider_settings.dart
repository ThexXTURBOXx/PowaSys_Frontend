import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powasys_frontend/bloc/cubits/data_cubit.dart';
import 'package:powasys_frontend/constants.dart';

class DividerSettings extends StatefulWidget {
  const DividerSettings({super.key});

  @override
  State<StatefulWidget> createState() => _DividerSettingsState();
}

class _DividerSettingsState extends State<DividerSettings> {
  @override
  Widget build(BuildContext ctx) => DropdownButton<int>(
    value: minDiv,
    icon: const Icon(Icons.arrow_downward),
    onChanged: (newValue) {
      if (newValue != null) {
        setState(() {
          minDiv = newValue;
          context.read<DataCubit>().fetchData(
            disabledPowadors: disabledPowadors,
            currentTrend: currentTrend,
            minDiv: minDiv,
          );
        });
      }
    },
    items: <int>[0, 1, 5, 10, 30, 60]
        .map<DropdownMenuItem<int>>(
          (value) => DropdownMenuItem<int>(value: value, child: Text('$value')),
        )
        .toList(growable: false),
  );
}
