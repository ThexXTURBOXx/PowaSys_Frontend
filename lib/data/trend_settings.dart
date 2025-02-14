import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powasys_frontend/bloc/cubits/data_cubit.dart';
import 'package:powasys_frontend/bloc/states.dart';
import 'package:powasys_frontend/constants.dart';
import 'package:powasys_frontend/data/trend.dart';

class TrendSettings extends StatefulWidget {
  const TrendSettings({super.key});

  @override
  State<StatefulWidget> createState() => _TrendSettingsState();
}

class _TrendSettingsState extends State<TrendSettings> {
  @override
  Widget build(BuildContext ctx) => BlocBuilder<DataCubit, DataState>(
    builder:
        (context, state) => Column(
          children: Trend.values
              .map(
                (t) => RadioListTile<Trend>(
                  title: Text(t.name(context)),
                  value: t,
                  groupValue: currentTrend,
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        currentTrend = value;
                        context.read<DataCubit>().fetchData(
                          disabledPowadors: disabledPowadors,
                          currentTrend: currentTrend,
                          minDiv: minDiv,
                        );
                      }
                    });
                  },
                ),
              )
              .toList(growable: false),
        ),
  );
}
