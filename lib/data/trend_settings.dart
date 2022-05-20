import 'package:flutter/material.dart';
import 'package:powasys_frontend/bloc/blocs/data_bloc.dart';
import 'package:powasys_frontend/bloc/events.dart';
import 'package:powasys_frontend/bloc/repo.dart';
import 'package:powasys_frontend/data/trend.dart';

class TrendSettings extends StatefulWidget {
  const TrendSettings({super.key});

  @override
  State<StatefulWidget> createState() => _TrendSettingsState();
}

class _TrendSettingsState extends State<TrendSettings> {
  final DataBloc _bloc = DataBloc();
  final PowaSysRepo _repo = PowaSysRepo();

  @override
  Widget build(BuildContext ctx) => Column(
        children: Trend.values
            .map(
              (t) => RadioListTile<Trend>(
                title: Text(t.name(context)),
                value: t,
                groupValue: _repo.currentTrend,
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      _repo.currentTrend = value;
                      _bloc.add(const FetchData());
                    }
                  });
                },
              ),
            )
            .toList(growable: false),
      );
}
