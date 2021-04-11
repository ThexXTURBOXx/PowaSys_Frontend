import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:powasys_frontend/config/config.dart';
import 'package:powasys_frontend/i18n/i18n.dart';
import 'package:powasys_frontend/navigation/footer.dart';
import 'package:powasys_frontend/navigation/header.dart';

class Home extends StatefulWidget {
  final PackageInfo packageInfo;

  const Home(this.packageInfo);

  @override
  State<StatefulWidget> createState() => _HomeState(packageInfo);
}

class _HomeState extends State<Home> {
  final PackageInfo packageInfo;
  int _counter = 0;

  _HomeState(this.packageInfo);

  @override
  Widget build(BuildContext context) {
    final barData = linesBarData();
    return Scaffold(
      appBar: AppBar(
        title: Logo(),
        actions: [
          HomeButton(),
          PopMenu(packageInfo),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: getFooterItems(),
      ),
      body: Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DataTable(columns: [
                const DataColumn(
                  label: Center(
                    child: Text(''),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      format(context, 'voltage'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      format(context, 'current'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      format(context, 'power'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      format(context, 'temperature'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ], rows: [
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
                    DataCell(
                      Center(
                        child: Text(
                          format(context, 'amount_format', [
                            '${_counter + 1}',
                            format(context, 'voltage_unit')
                          ]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          format(context, 'amount_format', [
                            '${_counter + 1}',
                            format(context, 'current_unit')
                          ]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          format(context, 'amount_format', [
                            '${_counter + 1}',
                            format(context, 'power_unit')
                          ]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          format(context, 'amount_format', [
                            '${_counter + 1}',
                            format(context, 'temperature_unit')
                          ]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
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
                    DataCell(
                      Center(
                        child: Text(
                          format(context, 'amount_format', [
                            '${_counter + 2}',
                            format(context, 'voltage_unit')
                          ]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          format(context, 'amount_format', [
                            '${_counter + 2}',
                            format(context, 'current_unit')
                          ]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          format(context, 'amount_format', [
                            '${_counter + 2}',
                            format(context, 'power_unit')
                          ]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          format(context, 'amount_format', [
                            '${_counter + 2}',
                            format(context, 'temperature_unit')
                          ]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
              Switch(
                value: themeSettings.isDark,
                onChanged: (state) {
                  setState(() {
                    themeSettings.setTheme(!themeSettings.isDark);
                  });
                },
              ),
              SizedBox(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                  child: LineChart(
                    LineChartData(
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots
                                .map((spot) => LineTooltipItem(
                                    format(context, 'amount_format', [
                                      '${spot.y}',
                                      format(context, getUnit(spot.barIndex)),
                                    ]),
                                    TextStyle(
                                      color: spot.bar.colors[0],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    )))
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
                            color: Color(0xff72719b),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          margin: 10,
                          getTitles: (value) {
                            switch (value.toInt()) {
                              case 2:
                                return 'SEPT';
                              case 7:
                                return 'OCT';
                              case 12:
                                return 'DEC';
                            }
                            return '';
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                            color: Color(0xff75729e),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          getTitles: (value) {
                            switch (value.toInt()) {
                              case 1:
                                return '1m';
                              case 2:
                                return '2m';
                              case 3:
                                return '3m';
                              case 4:
                                return '5m';
                            }
                            return '';
                          },
                          margin: 8,
                          reservedSize: 30,
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: const Border(
                          bottom: BorderSide(
                            color: Color(0xff4e4965),
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
                      maxX: 14,
                      maxY: 4,
                      minY: 0,
                      lineBarsData: barData,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter++;
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
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
