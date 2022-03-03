import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:powasys_frontend/bloc/blocs/data_bloc.dart';
import 'package:powasys_frontend/bloc/events.dart';
import 'package:powasys_frontend/bloc/repo.dart';
import 'package:powasys_frontend/data/trend.dart';
import 'package:powasys_frontend/generated/l10n.dart';
import 'package:sprintf/sprintf.dart';

class TrendDiagram extends StatefulWidget {
  const TrendDiagram({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TrendDiagramState();
}

class _TrendDiagramState extends State<TrendDiagram> {
  static const double hourInMs = 1000 * 60 * 60;
  static const double dayInMs = hourInMs * 24;

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
  Widget build(BuildContext context) {
    final now = DateTime.now().millisecondsSinceEpoch.toDouble();
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (touchedSpots) => touchedSpots
                        .map(
                          (spot) => LineTooltipItem(
                            sprintf(S.of(context).amount_format, [
                              '${spot.y}',
                              _repo.currentTrend.unit(context),
                            ]),
                            TextStyle(
                              color: spot.bar.colors[0],
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        )
                        .toList(),
                    tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                  ),
                  touchCallback: (touchEvent, touchResponse) {},
                  handleBuiltInTouches: true,
                ),
                gridData: FlGridData(
                  show: false,
                ),
                titlesData: FlTitlesData(
                  topTitles: SideTitles(
                    showTitles: false,
                  ),
                  bottomTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 22,
                    interval: hourInMs,
                    getTextStyles: (ctx, value) => const TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    margin: 10,
                    getTitles: (value) => DateFormat.Hm().format(
                      DateTime.fromMillisecondsSinceEpoch(
                        value.toInt(),
                      ),
                    ),
                  ),
                  leftTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: const Border(
                    bottom: BorderSide(
                      color: Colors.indigo,
                      width: 4,
                    ),
                    left: BorderSide(
                      color: Colors.transparent,
                    ),
                    right: BorderSide(
                      color: Colors.transparent,
                    ),
                    top: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                minX: now - dayInMs,
                maxX: now,
                minY: _repo.min,
                maxY: _repo.max,
                lineBarsData: linesBarData(),
              ),
            ),
          ),
        ),
        Column(
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
        ),
        Column(
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
        ),
      ],
    );
  }

  List<LineChartBarData> linesBarData() {
    final d = _repo.data;
    return d.entries
        .map(
          (e) => LineChartBarData(
            spots: e.value,
            isCurved: false,
            colors: [_repo.powadors[e.key]!.item2],
            isStrokeCapRound: true,
            belowBarData: BarAreaData(
              show: false,
            ),
          ),
        )
        .toList(growable: false);
  }
}
