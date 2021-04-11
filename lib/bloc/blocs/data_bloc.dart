import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powasys_frontend/bloc/events/data_events.dart';
import 'package:powasys_frontend/bloc/repos/data_repo.dart';
import 'package:powasys_frontend/bloc/states/data_state.dart';
import 'package:powasys_frontend/data/trend.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  static DataBloc? _singleton;
  final DataRepo _repo;

  factory DataBloc() {
    _singleton ??= DataBloc._internal(DataRepo());
    return _singleton!;
  }

  DataBloc._internal(this._repo) : super(NotFetched());

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    try {
      yield Fetching();

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
        yield FetchedData();
      }
    } catch (e) {
      yield FetchError();
    }
  }
}
