import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:powasys_frontend/bloc/blocs/data_bloc.dart';
import 'package:powasys_frontend/bloc/repo.dart';
import 'package:powasys_frontend/data/trend.dart';
import 'package:powasys_frontend/generated/l10n.dart';
import 'package:sprintf/sprintf.dart';

class TrendDiagram extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TrendDiagramState();
}

class _TrendDiagramState extends State<TrendDiagram> {
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
    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0, left: 16.0),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (touchedSpots) {
                  return touchedSpots
                      .map(
                        (spot) => LineTooltipItem(
                          sprintf(S.of(context).amount_format, [
                            '${spot.y}',
                            Trend.values[spot.barIndex].unit(context),
                          ]),
                          TextStyle(
                            color: spot.bar.colors[0],
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      )
                      .toList();
                },
                tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
              ),
              touchCallback: (LineTouchResponse touchResponse) {},
              handleBuiltInTouches: true,
            ),
            gridData: FlGridData(
              show: false,
            ),
            titlesData: FlTitlesData(
              bottomTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                getTextStyles: (value) => const TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                margin: 10,
                getTitles: (value) => '$value',
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
            minX: 0,
            maxX: 23,
            minY: 0,
            maxY: 721,
            lineBarsData: linesBarData(),
          ),
        ),
      ),
    );
  }

  List<LineChartBarData> linesBarData() {
    final d = _repo.data ?? {};
    final spots = <Trend, List<FlSpot>>{};
    for (final dtm in d.entries) {
      for (final td in dtm.value.entries) {
        spots[td.key] ??= [];
        spots[td.key]!.add(FlSpot(dtm.key.hour as double, td.value));
      }
    }
    for (final l in spots.values) {
      l.sort((s1, s2) => s1.x.compareTo(s2.x));
    }
    return Trend.values
        .map(
          (t) => LineChartBarData(
            spots: spots[t],
            isCurved: true,
            colors: [
              t.color,
            ],
            isStrokeCapRound: true,
            belowBarData: BarAreaData(
              show: false,
            ),
          ),
        )
        .toList();
  }
}
