import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:powasys_frontend/bloc/blocs/data_bloc.dart';
import 'package:powasys_frontend/bloc/repo.dart';
import 'package:powasys_frontend/data/trend.dart';
import 'package:powasys_frontend/generated/l10n.dart';
import 'package:sprintf/sprintf.dart';

class TrendTable extends StatefulWidget {
  const TrendTable({super.key});

  @override
  State<StatefulWidget> createState() => _TrendTableState();
}

class _TrendTableState extends State<TrendTable> {
  final DataBloc _bloc = DataBloc();
  final PowaSysRepo _repo = PowaSysRepo();

  @override
  void initState() {
    super.initState();
    _bloc.stream.listen((event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => DataTable(
        columns: <DataColumn>[const _EmptyDataColumn()] +
            Trend.values.map((v) => _DataColumn(v.name(context))).toList(),
        rows: _repo.latest.entries
                .map(
                  (e) => DataRow(
                    cells: <DataCell>[
                          _InfoDataCell(
                            sprintf(
                              S.of(context).currently,
                              [
                                _repo.powadors[e.key]!.item1,
                                '${e.value.item1}'
                              ],
                            ),
                          )
                        ] +
                        Trend.values
                            .map(
                              (t) => _ValueDataCell(
                                context,
                                e.value.item2[t],
                                t.unit(context),
                              ),
                            )
                            .toList(),
                  ),
                )
                .toList(growable: false) +
            _repo.averages.entries
                .map(
                  (e) => DataRow(
                    cells: <DataCell>[
                          _InfoDataCell(
                            sprintf(
                              S.of(context).average,
                              [_repo.powadors[e.key]!.item1],
                            ),
                          )
                        ] +
                        Trend.values
                            .map(
                              (t) => _ValueDataCell(
                                context,
                                e.value[t],
                                t.unit(context),
                              ),
                            )
                            .toList(),
                  ),
                )
                .toList(growable: false) +
            _repo.max.entries
                .map(
                  (e) => DataRow(
                    cells: <DataCell>[
                          _InfoDataCell(
                            sprintf(
                              S.of(context).max,
                              [_repo.powadors[e.key]!.item1],
                            ),
                          )
                        ] +
                        Trend.values
                            .map(
                              (t) => _ValueDataCell(
                                context,
                                e.value[t],
                                t.unit(context),
                              ),
                            )
                            .toList(),
                  ),
                )
                .toList(growable: false),
      );
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
              sprintf(
                S.of(context).amount_format,
                [amount?.toStringAsFixed(2) ?? '', unit],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
}
