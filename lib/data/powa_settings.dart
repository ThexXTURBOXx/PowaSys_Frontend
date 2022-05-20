import 'package:flutter/material.dart';
import 'package:powasys_frontend/bloc/blocs/data_bloc.dart';
import 'package:powasys_frontend/bloc/events.dart';
import 'package:powasys_frontend/bloc/repo.dart';

class PowaSettings extends StatefulWidget {
  const PowaSettings({super.key});

  @override
  State<StatefulWidget> createState() => _PowaSettingsState();
}

class _PowaSettingsState extends State<PowaSettings> {
  final DataBloc _bloc = DataBloc();
  final PowaSysRepo _repo = PowaSysRepo();

  @override
  Widget build(BuildContext ctx) => Column(
        children: _repo.powadors.entries
            .map(
              (e) => CheckboxListTile(
                title: Text(e.value.item1),
                value: !_repo.disabledPowadors.contains(e.key),
                onChanged: (value) {
                  setState(() {
                    if (value ?? false) {
                      _repo.disabledPowadors.remove(e.key);
                    } else {
                      _repo.disabledPowadors.add(e.key);
                    }
                    _bloc.add(const FetchData());
                  });
                },
              ),
            )
            .toList(growable: false),
      );
}
