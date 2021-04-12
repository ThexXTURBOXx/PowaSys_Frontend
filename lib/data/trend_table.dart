import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:powasys_frontend/bloc/data/data_bloc.dart';
import 'package:powasys_frontend/bloc/data/data_repo.dart';
import 'package:powasys_frontend/data/trend.dart';
import 'package:powasys_frontend/i18n/i18n.dart';

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
      columns: [
            const DataColumn(
              label: Text(''),
            ),
          ] +
          Trend.values
              .map(
                (v) => DataColumn(
                  label: Expanded(
                    child: Text(
                      format(context, v.name),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
              .toList(),
      rows: [
        DataRow(
          cells: [
                DataCell(
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      format(context, 'currently', ['${DateTime.now()}']),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ] +
              Trend.values
                  .map(
                    (v) => DataCell(
                      Center(
                        child: Text(
                          format(context, 'amount_format',
                              ['1', format(context, v.unit)]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
        DataRow(
          cells: [
                DataCell(
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      format(context, 'average'),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ] +
              Trend.values
                  .map(
                    (t) => DataCell(
                      Center(
                        child: Text(
                          format(context, 'amount_format',
                              [getAverage(t) ?? '', format(context, t.unit)]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }

  double? getAverage(Trend t) {
    return _repo.averages == null ? null : _repo.averages![t];
  }
}
