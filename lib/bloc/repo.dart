import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:powasys_frontend/data/trend.dart';
import 'package:tuple/tuple.dart';

class PowaSysRepo {
  static final PowaSysRepo _singleton = PowaSysRepo._internal();

  static final Client _client = Client();

  final List<int> disabledPowadors = [];
  Trend currentTrend = Trend.netPower;

  double min = 0;
  double max = 0;
  Map<int, Tuple2<String, Color>> powadors = {};
  Map<int, Tuple2<DateTime, Map<Trend, double>>> latest = {};
  Map<int, Map<Trend, double>> averages = {};
  Map<int, List<FlSpot>> data = {};

  factory PowaSysRepo() => _singleton;

  PowaSysRepo._internal();

  Client get client => _client;
}
