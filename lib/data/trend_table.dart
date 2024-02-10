import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powasys_frontend/bloc/cubits/data_cubit.dart';
import 'package:powasys_frontend/bloc/states.dart';
import 'package:powasys_frontend/data/trend.dart';
import 'package:powasys_frontend/generated/l10n.dart';
import 'package:sprintf/sprintf.dart';

class TrendTable extends StatefulWidget {
  const TrendTable({super.key});

  @override
  State<StatefulWidget> createState() => _TrendTableState();
}

class _TrendTableState extends State<TrendTable> {
  @override
  Widget build(BuildContext ctx) => BlocConsumer<DataCubit, DataState>(
        listener: (context, state) => setState(() {}),
        builder: (context, state) => DataTable(
          columns: <DataColumn>[const _EmptyDataColumn()] +
              Trend.values.map((v) => _DataColumn(v.name(context))).toList(),
          rows: state.latest.entries
                  .map(
                    (e) => DataRow(
                      cells: <DataCell>[
                            _InfoDataCell(
                              sprintf(
                                S.of(context).currently,
                                [
                                  state.powadors[e.key]!.item1,
                                  '${e.value.item1}',
                                ],
                              ),
                            ),
                          ] +
                          Trend.values
                              .map(
                                (t) => _ValueDataCell(
                                  context,
                                  e.value.item2[t],
                                  t,
                                ),
                              )
                              .toList(),
                    ),
                  )
                  .toList(growable: false) +
              state.averages.entries
                  .map(
                    (e) => DataRow(
                      cells: <DataCell>[
                            _InfoDataCell(
                              sprintf(
                                S.of(context).average,
                                [state.powadors[e.key]!.item1],
                              ),
                            ),
                          ] +
                          Trend.values
                              .map(
                                (t) => _ValueDataCell(
                                  context,
                                  e.value[t],
                                  t,
                                ),
                              )
                              .toList(),
                    ),
                  )
                  .toList(growable: false) +
              state.max.entries
                  .map(
                    (e) => DataRow(
                      cells: <DataCell>[
                            _InfoDataCell(
                              sprintf(
                                S.of(context).max,
                                [state.powadors[e.key]!.item1],
                              ),
                            ),
                          ] +
                          Trend.values
                              .map(
                                (t) => _ValueDataCell(
                                  context,
                                  e.value[t],
                                  t,
                                ),
                              )
                              .toList(),
                    ),
                  )
                  .toList(growable: false),
        ),
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
  _ValueDataCell(BuildContext context, num? amount, Trend trend)
      : super(
          Center(
            child: Text(
              trend.format(context, amount),
              textAlign: TextAlign.center,
            ),
          ),
        );
}
