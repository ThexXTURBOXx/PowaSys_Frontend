import 'dart:html';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:powasys_frontend/data/trend.dart';
import 'package:tuple/tuple.dart';

class BlocState<State> {
  final State state;
  final dynamic ex;

  const BlocState(
    this.state, {
    this.ex,
  });
}

class DataState extends BlocState<DataFetchState> {
  final double minVal;
  final double maxVal;
  final Map<int, Tuple2<String, Color>> powadors;
  final Map<int, Tuple2<DateTime, Map<Trend, num>>> latest;
  final Map<int, Map<Trend, num>> averages;
  final Map<int, Map<Trend, num>> max;
  final Map<int, List<FlSpot>> data;

  const DataState(
    super.state, {
    super.ex,
    this.minVal = 0,
    this.maxVal = 0,
    this.powadors = const {},
    this.latest = const {},
    this.averages = const {},
    this.max = const {},
    this.data = const {},
  });

  DataState copyWith({
    DataFetchState? state,
    dynamic ex,
    double? minVal,
    double? maxVal,
    Map<int, Tuple2<String, Color>>? powadors,
    Map<int, Tuple2<DateTime, Map<Trend, num>>>? latest,
    Map<int, Map<Trend, num>>? averages,
    Map<int, Map<Trend, num>>? max,
    Map<int, List<FlSpot>>? data,
  }) =>
      DataState(
        state ?? super.state,
        ex: ex ?? super.ex,
        minVal: minVal ?? this.minVal,
        maxVal: maxVal ?? this.maxVal,
        powadors: powadors ?? this.powadors,
        latest: latest ?? this.latest,
        averages: averages ?? this.averages,
        max: max ?? this.max,
        data: data ?? this.data,
      );
}

enum DataFetchState {
  notFetched(),
  fetching(),
  fetchedData(finished: true),
  fetchError(finished: true, errored: true);

  final bool finished;
  final bool errored;

  const DataFetchState({
    this.finished = false,
    this.errored = false,
  });
}

class ExportState extends BlocState<ExportGenState> {
  final AnchorElement? toDownload;

  const ExportState(
    super.state, {
    super.ex,
    this.toDownload,
  });

  ExportState copyWith({
    ExportGenState? state,
    dynamic ex,
    AnchorElement? toDownload,
  }) =>
      ExportState(
        state ?? super.state,
        ex: ex ?? super.ex,
        toDownload: toDownload ?? this.toDownload,
      );
}

enum ExportGenState {
  notStarted(),
  exporting(),
  exported(finished: true),
  exportError(finished: true, errored: true);

  final bool finished;
  final bool errored;

  const ExportGenState({
    this.finished = false,
    this.errored = false,
  });
}
