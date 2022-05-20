import 'package:flutter/material.dart';
import 'package:powasys_frontend/bloc/blocs/data_bloc.dart';
import 'package:powasys_frontend/bloc/events.dart';
import 'package:powasys_frontend/bloc/repo.dart';

class DividerSettings extends StatefulWidget {
  const DividerSettings({super.key});

  @override
  State<StatefulWidget> createState() => _DividerSettingsState();
}

class _DividerSettingsState extends State<DividerSettings> {
  final DataBloc _bloc = DataBloc();
  final PowaSysRepo _repo = PowaSysRepo();

  @override
  Widget build(BuildContext ctx) => DropdownButton<int>(
        value: _repo.minDiv,
        icon: const Icon(Icons.arrow_downward),
        onChanged: (newValue) {
          setState(() {
            _repo.minDiv = newValue!;
            _bloc.add(const FetchData());
          });
        },
        items: <int>[0, 1, 5, 10, 30, 60]
            .map<DropdownMenuItem<int>>(
              (value) => DropdownMenuItem<int>(
                value: value,
                child: Text('$value'),
              ),
            )
            .toList(growable: false),
      );
}
