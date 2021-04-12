import 'package:powasys_frontend/data/trend.dart';

class DataRepo {
  static DataRepo? _singleton;

  Map<DateTime, Map<Trend, double>>? data;
  Map<Trend, double>? averages;

  factory DataRepo() {
    _singleton ??= DataRepo._internal();
    return _singleton!;
  }

  DataRepo._internal();
}
