import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powasys_frontend/bloc/repos/data_repo.dart';
import 'package:powasys_frontend/bloc/states.dart';
import 'package:powasys_frontend/data/trend.dart';
import 'package:powasys_frontend/util/hex_color.dart';
import 'package:tuple/tuple.dart';

class DataCubit extends Cubit<DataState> {
  final DataRepo _dataRepo;

  DataCubit(this._dataRepo) : super(const DataState(PowaSysState.notFetched));

  Future<void> fetchData({
    required List<int> disabledPowadors,
    required Trend currentTrend,
    required int minDiv,
  }) async {
    try {
      emit(state.copyWith(state: PowaSysState.fetching));

      final powadors = <int, Tuple2<String, Color>>{};
      for (final entry in await _dataRepo.getPowas()) {
        powadors[int.parse(entry['powadorId'].toString())] = Tuple2(
          entry['name'].toString(),
          HexColor.fromHex(
            entry['color'].toString(),
          ),
        );
      }

      final parsed24h = await _dataRepo.get24h(minDiv: minDiv);

      final latest = <int, Tuple2<DateTime, Map<Trend, double>>>{};
      for (final entry in parsed24h['latest']) {
        latest[int.parse(entry['powadorId'].toString())] = Tuple2(
          DateTime.parse(entry['time'].toString()),
          Trend.values.asMap().map(
                (id, trend) =>
                    MapEntry(trend, double.parse(entry[trend.id].toString())),
              ),
        );
      }

      final averages = <int, Map<Trend, double>>{};
      for (final entry in parsed24h['averages']) {
        averages[int.parse(entry['powadorId'].toString())] =
            Trend.values.asMap().map(
                  (id, trend) =>
                      MapEntry(trend, double.parse(entry[trend.id].toString())),
                );
      }

      final max = <int, Map<Trend, double>>{};
      for (final entry in parsed24h['max']) {
        max[int.parse(entry['powadorId'].toString())] =
            Trend.values.asMap().map(
                  (id, trend) =>
                      MapEntry(trend, double.parse(entry[trend.id].toString())),
                );
      }

      var minVal = 0.0;
      var maxVal = 0.0;
      final data = Map<int, List<FlSpot>>.fromEntries(
        powadors.keys.map((e) => MapEntry(e, [])),
      );
      for (final entry in parsed24h['data']) {
        final powaId = int.parse(entry['powadorId'].toString());
        if (!disabledPowadors.contains(powaId)) {
          final value = double.parse(entry[currentTrend.id].toString());
          minVal = value < minVal ? value : minVal;
          maxVal = value > maxVal ? value : maxVal;
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

      emit(
        state.copyWith(
          state: PowaSysState.fetchedData,
          powadors: powadors,
          minVal: minVal,
          maxVal: maxVal,
          latest: latest,
          averages: averages,
          max: max,
          data: data,
        ),
      );
    } catch (e) {
      emit(state.copyWith(state: PowaSysState.fetchError));
    }
  }
}
