import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powasys_frontend/bloc/cubits/data_cubit.dart';
import 'package:powasys_frontend/bloc/states.dart';
import 'package:powasys_frontend/constants.dart';

class PowaSettings extends StatefulWidget {
  const PowaSettings({super.key});

  @override
  State<StatefulWidget> createState() => _PowaSettingsState();
}

class _PowaSettingsState extends State<PowaSettings> {
  @override
  Widget build(BuildContext ctx) => BlocBuilder<DataCubit, DataState>(
        builder: (context, state) => Column(
          children: state.powadors.entries
              .map(
                (e) => CheckboxListTile(
                  title: Text(e.value.item1),
                  value: !disabledPowadors.contains(e.key),
                  onChanged: (value) {
                    setState(() {
                      if (value ?? false) {
                        disabledPowadors.remove(e.key);
                      } else {
                        disabledPowadors.add(e.key);
                      }
                      context.read<DataCubit>().fetchData(
                            disabledPowadors: disabledPowadors,
                            currentTrend: currentTrend,
                            minDiv: minDiv,
                          );
                    });
                  },
                ),
              )
              .toList(growable: false),
        ),
      );
}
