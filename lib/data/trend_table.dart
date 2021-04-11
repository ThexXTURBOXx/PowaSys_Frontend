import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:powasys_frontend/data/trend.dart';
import 'package:powasys_frontend/i18n/i18n.dart';

class TrendTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
            const DataColumn(
              label: Center(
                child: Text(''),
              ),
            ),
          ] +
          Trend.values
              .map(
                (v) => DataColumn(
                  label: Center(
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
                    (v) => DataCell(
                      Center(
                        child: Text(
                          format(context, 'amount_format',
                              ['2', format(context, v.unit)]),
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

  String getUnit(int index) {
    switch (index) {
      case 0:
        return 'voltage_unit';
      case 1:
        return 'current_unit';
      case 2:
        return 'power_unit';
      default:
        return 'temperature_unit';
    }
  }

  List<LineChartBarData> linesBarData() {
    final lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
      ],
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      isStrokeCapRound: true,
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 2.8),
        FlSpot(7, 1.2),
        FlSpot(10, 2.8),
        FlSpot(12, 2.6),
        FlSpot(13, 3.9),
      ],
      isCurved: true,
      colors: [
        const Color(0xffaa4cfc),
      ],
      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );
    final lineChartBarData3 = LineChartBarData(
      spots: [
        FlSpot(1, 2.8),
        FlSpot(3, 1.9),
        FlSpot(6, 3),
        FlSpot(10, 1.3),
        FlSpot(13, 2.5),
      ],
      isCurved: true,
      colors: const [
        Color(0xff27b6fc),
      ],
      isStrokeCapRound: true,
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final lineChartBarData4 = LineChartBarData(
      spots: [
        FlSpot(1, 2.8),
        FlSpot(5, 1.9),
        FlSpot(6, 3),
        FlSpot(10, 1.4),
        FlSpot(13, 2.5),
      ],
      isCurved: true,
      colors: const [
        Color(0xffaaaa00),
      ],
      isStrokeCapRound: true,
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
      lineChartBarData2,
      lineChartBarData3,
      lineChartBarData4,
    ];
  }
}
