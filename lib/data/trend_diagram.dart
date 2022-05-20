import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:powasys_frontend/bloc/blocs/data_bloc.dart';
import 'package:powasys_frontend/bloc/repo.dart';
import 'package:powasys_frontend/generated/l10n.dart';
import 'package:sprintf/sprintf.dart';

class TrendDiagram extends StatefulWidget {
  const TrendDiagram({super.key});

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
  Widget build(BuildContext context) => Column(
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
                                color: spot.bar.color,
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
                    show: true,
                    topTitles: AxisTitles(),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        // TODO(Nico): Why the fuck does this not work?
                        showTitles: false,
                        interval: 100,
                      ),
                    ),
                    rightTitles: AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: hourInMs,
                        getTitlesWidget: (value, meta) => Text(
                          DateFormat.Hm().format(
                            DateTime.fromMillisecondsSinceEpoch(
                              value.toInt(),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
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
                  minY: _repo.minVal,
                  maxY: _repo.maxVal,
                  lineBarsData: linesBarData(),
                ),
              ),
            ),
          ),
        ],
      );

  double get now => DateTime.now().millisecondsSinceEpoch.toDouble();

  List<LineChartBarData> linesBarData() => _repo.data.entries
      .map(
        (e) => LineChartBarData(
          spots: e.value,
          isCurved: false,
          color: _repo.powadors[e.key]!.item2,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(
            show: false,
          ),
        ),
      )
      .toList(growable: false);
}
