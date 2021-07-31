import 'package:powasys_frontend/data/trend.dart';

class PowaSysRepo {
  static final PowaSysRepo _singleton = PowaSysRepo._internal();

  Map<DateTime, Map<Trend, double>>? data;
  Map<Trend, double>? averages;

  factory PowaSysRepo() => _singleton;

  PowaSysRepo._internal();
}
