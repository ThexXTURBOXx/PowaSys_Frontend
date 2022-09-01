// ignore_for_file: missing_whitespace_between_adjacent_strings
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powasys_frontend/bloc/states.dart';
import 'package:powasys_frontend/constants.dart';
import 'package:powasys_frontend/data/fl_spot.dart';
import 'package:powasys_frontend/data/trend.dart';
import 'package:tuple/tuple.dart';

class ExportCubit extends Cubit<ExportState> {
  ExportCubit() : super(const ExportState(ExportGenState.notStarted));

  Future<void> exportData(Map<int, List<PowaSpot>> data) async {
    try {
      emit(state.copyWith(state: ExportGenState.exporting));

      var toExport = 'Powador ID;Time;State;Generator Voltage;'
          'Generator Current;Generator Power;Net Voltage;Net Current;Net Power;'
          'Temperature\n';

      final entries = data.entries
          .expand((e) => e.value.map((f) => Tuple2(f, e.key)))
          .toList(growable: false);
      entries.sort((a, b) {
        final comp = a.item1.compare(b.item1);
        return comp != 0 ? comp : a.item2 - b.item2;
      });
      toExport += entries
          .map(
            (e) => '${e.item2};'
                '${e.item1.time};'
                '${e.item1.values[Trend.state] as int?};'
                '${decimalFormatOne.format(e.item1.values[Trend.genVoltage])};'
                '${decimalFormatTwo.format(e.item1.values[Trend.genCurrent])};'
                '${e.item1.values[Trend.genPower] as int?};'
                '${decimalFormatOne.format(e.item1.values[Trend.netVoltage])};'
                '${decimalFormatTwo.format(e.item1.values[Trend.netCurrent])};'
                '${e.item1.values[Trend.netPower] as int?};'
                '${e.item1.values[Trend.temperature] as int?}',
          )
          .join('\n');

      emit(
        state.copyWith(
          state: ExportGenState.exported,
          toExport: toExport,
        ),
      );
    } catch (e) {
      emit(state.copyWith(state: ExportGenState.exportError, ex: e));
    }
  }
}
