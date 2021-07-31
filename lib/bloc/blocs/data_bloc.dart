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

  DataBloc._internal() : super(PowaSysState.NOT_FETCHED);

  @override
  Stream<PowaSysState> mapEventToState(DataEvent event) async* {
    try {
      yield PowaSysState.FETCHING;

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
        yield PowaSysState.FETCHED_DATA;
      }
    } catch (e) {
      yield PowaSysState.FETCH_ERROR;
    }
  }
}
