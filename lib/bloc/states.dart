import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:powasys_frontend/data/trend.dart';
import 'package:tuple/tuple.dart';

class BlocState {
  final PowaSysState state;

  const BlocState(this.state);
}

class DataState extends BlocState {
  final double minVal;
  final double maxVal;
  final Map<int, Tuple2<String, Color>> powadors;
  final Map<int, Tuple2<DateTime, Map<Trend, double>>> latest;
  final Map<int, Map<Trend, double>> averages;
  final Map<int, Map<Trend, double>> max;
  final Map<int, List<FlSpot>> data;

  const DataState(
    super.state, {
    this.minVal = 0,
    this.maxVal = 0,
    this.powadors = const {},
    this.latest = const {},
    this.averages = const {},
    this.max = const {},
    this.data = const {},
  });

  DataState copyWith({
    PowaSysState? state,
    double? minVal,
    double? maxVal,
    Map<int, Tuple2<String, Color>>? powadors,
    Map<int, Tuple2<DateTime, Map<Trend, double>>>? latest,
    Map<int, Map<Trend, double>>? averages,
    Map<int, Map<Trend, double>>? max,
    Map<int, List<FlSpot>>? data,
  }) =>
      DataState(
        state ?? this.state,
        minVal: minVal ?? this.minVal,
        maxVal: maxVal ?? this.maxVal,
        powadors: powadors ?? this.powadors,
        latest: latest ?? this.latest,
        averages: averages ?? this.averages,
        max: max ?? this.max,
        data: data ?? this.data,
      );
}

enum PowaSysState {
  notFetched(),
  fetching(),
  fetchedData(finished: true),
  fetchError(finished: true, errored: true);

  final bool finished;
  final bool errored;

  const PowaSysState({
    this.finished = false,
    this.errored = false,
  });
}
