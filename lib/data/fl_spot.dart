import 'package:fl_chart/fl_chart.dart';
import 'package:powasys_frontend/data/trend.dart';
import 'package:powasys_frontend/util/math.dart';

class PowaSpot extends FlSpot {
  final DateTime time;
  final Map<Trend, double?> values;

  PowaSpot(super.x, super.y, this.time, this.values);

  PowaSpot.fromDateTime(DateTime time, double y, Map<Trend, double?> values)
      : this(time.millisecondsSinceEpoch.toDouble(), y, time, values);

  int compare(PowaSpot other) {
    final comp = signum(x - other.x);
    return comp != 0 ? comp : signum(y - other.y);
  }
}
