import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:powasys_frontend/bloc/data/data_bloc.dart';
import 'package:powasys_frontend/bloc/data/data_repo.dart';
import 'package:powasys_frontend/data/trend.dart';
import 'package:powasys_frontend/generated/l10n.dart';
import 'package:sprintf/sprintf.dart';

class TrendTable extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TrendTableState();
}

class _TrendTableState extends State<TrendTable> {
  final DataBloc _bloc = DataBloc();
  final DataRepo _repo = DataRepo();

  @override
  void initState() {
    super.initState();
    _bloc.stream.listen((event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: <DataColumn>[const _EmptyDataColumn()] +
          Trend.values.map((v) => _DataColumn(v.name(context))).toList(),
      rows: [
        DataRow(
          cells: <DataCell>[
                _InfoDataCell(
                    sprintf(S.of(context).currently, ['${DateTime.now()}']))
              ] +
              Trend.values
                  // TODO(Nico): Replace 1
                  .map((t) => _ValueDataCell(context, 1, t.unit(context)))
                  .toList(),
        ),
        DataRow(
          cells: <DataCell>[_InfoDataCell(S.of(context).average)] +
              Trend.values
                  .map((t) =>
                      _ValueDataCell(context, getAverage(t), t.unit(context)))
                  .toList(),
        ),
      ],
    );
  }

  double? getAverage(Trend t) {
    return _repo.averages == null ? null : _repo.averages![t];
  }
}

class _EmptyDataColumn extends DataColumn {
  const _EmptyDataColumn() : super(label: const Text(''));
}

class _DataColumn extends DataColumn {
  _DataColumn(String name)
      : super(
          label: Expanded(
            child: Text(
              name,
              textAlign: TextAlign.center,
            ),
          ),
        );
}

class _InfoDataCell extends DataCell {
  _InfoDataCell(String label)
      : super(
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              label,
              textAlign: TextAlign.end,
            ),
          ),
        );
}

class _ValueDataCell extends DataCell {
  _ValueDataCell(BuildContext context, double? amount, String unit)
      : super(
          Center(
            child: Text(
              sprintf(S.of(context).amount_format, [amount ?? '', unit]),
              textAlign: TextAlign.center,
            ),
          ),
        );
}
