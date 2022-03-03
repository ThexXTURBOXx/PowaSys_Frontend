import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powasys_frontend/bloc/events.dart';
import 'package:powasys_frontend/bloc/repo.dart';
import 'package:powasys_frontend/bloc/states.dart';
import 'package:powasys_frontend/constants.dart';
import 'package:powasys_frontend/data/trend.dart';
import 'package:powasys_frontend/util/hex_color.dart';
import 'package:tuple/tuple.dart';

class DataBloc extends Bloc<DataEvent, PowaSysState> {
  static final DataBloc _singleton = DataBloc._internal();

  final PowaSysRepo _repo = PowaSysRepo();

  factory DataBloc() => _singleton;

  DataBloc._internal() : super(PowaSysState.notFetched) {
    on<FetchData>(_fetchData);
  }

  Future<void> _fetchData(
    FetchData event,
    Emitter<PowaSysState> emit,
  ) async {
    try {
      emit(PowaSysState.fetching);

      final responsePowas =
          await _repo.client.get(Uri.parse('$apiBaseUrl/powas'));
      final parsedPowas = json.decode(responsePowas.body);
      final powas = <int, Tuple2<String, Color>>{};

      for (final entry in parsedPowas) {
        powas[int.parse(entry['powadorId'].toString())] = Tuple2(
          entry['name'].toString(),
          HexColor.fromHex(
            entry['color'].toString(),
          ),
        );
      }

      _repo.powadors = powas;
      final response24h = await _repo.client.get(Uri.parse('$apiBaseUrl/24h'));
      final parsed24h = json.decode(response24h.body);

      final averages = <int, Map<Trend, double>>{};
      final latest = <int, Tuple2<DateTime, Map<Trend, double>>>{};
      final data = Map<int, List<FlSpot>>.fromEntries(
        powas.keys.map((e) => MapEntry(e, [])),
      );

      for (final entry in parsed24h['latest']) {
        latest[int.parse(entry['powadorId'].toString())] = Tuple2(
          DateTime.parse(entry['time'].toString()),
          Trend.values.asMap().map(
                (id, trend) =>
                    MapEntry(trend, double.parse(entry[trend.id].toString())),
              ),
        );
      }

      for (final entry in parsed24h['averages']) {
        averages[int.parse(entry['powadorId'].toString())] =
            Trend.values.asMap().map(
                  (id, trend) =>
                      MapEntry(trend, double.parse(entry[trend.id].toString())),
                );
      }

      var min = 0.0;
      var max = 0.0;
      for (final entry in parsed24h['data']) {
        final powaId = int.parse(entry['powadorId'].toString());
        if (!_repo.disabledPowadors.contains(powaId)) {
          final value = double.parse(entry[_repo.currentTrend.id].toString());
          min = value < min ? value : min;
          max = value > max ? value : max;
          data[powaId]!.add(
            FlSpot(
              DateTime.parse(entry['time'].toString())
                  .millisecondsSinceEpoch
                  .toDouble(),
              value,
            ),
          );
        }
      }

      _repo.min = min;
      _repo.max = max;
      _repo.latest = latest;
      _repo.averages = averages;
      _repo.data = data;

      emit(PowaSysState.fetchedData);
    } catch (e) {
      emit(PowaSysState.fetchError);
    }
  }
}
