import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powasys_frontend/bloc/events.dart';
import 'package:powasys_frontend/bloc/repo.dart';
import 'package:powasys_frontend/bloc/states.dart';
import 'package:powasys_frontend/data/trend.dart';

class DataBloc extends Bloc<DataEvent, PowaSysState> {
  static final DataBloc _singleton = DataBloc._internal();

  final PowaSysRepo _repo = PowaSysRepo();

  factory DataBloc() => _singleton;

  DataBloc._internal() : super(PowaSysState.notFetched) {
    on<FetchData>(_fetchData);
  }

  Future<void> _fetchData(
    DataEvent event,
    Emitter<PowaSysState> emit,
  ) async {
    try {
      emit(PowaSysState.fetching);

      if (event is FetchData) {
        final r = Random();
        // TODO(Nico): Actually fetch data
        await Future.delayed(const Duration(seconds: 2));
        final data = <DateTime, Map<Trend, double>>{};
        for (var i = 0; i < 24; i++) {
          final f = Trend.values
              .asMap()
              .map((i, v) => MapEntry(v, r.nextDouble() + r.nextInt(720)));
          data[DateTime.now().subtract(Duration(hours: i))] = f;
        }
        _repo.data = data;
        _repo.averages = Trend.values
            .asMap()
            .map((i, v) => MapEntry(v, r.nextDouble() + r.nextInt(720)));
        emit(PowaSysState.fetchedData);
      }
    } catch (e) {
      emit(PowaSysState.fetchError);
    }
  }
}
