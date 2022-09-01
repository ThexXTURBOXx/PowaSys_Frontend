// ignore_for_file: missing_whitespace_between_adjacent_strings
import 'dart:convert';
import 'dart:html';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powasys_frontend/bloc/repos/data_repo.dart';
import 'package:powasys_frontend/bloc/states.dart';
import 'package:powasys_frontend/constants.dart';
import 'package:powasys_frontend/data/trend.dart';
import 'package:powasys_frontend/generated/l10n.dart';
import 'package:tuple/tuple.dart';

class ExportCubit extends Cubit<ExportState> {
  final DataRepo _dataRepo;

  ExportCubit(this._dataRepo)
      : super(const ExportState(ExportGenState.notStarted));

  Future<void> exportData(S s, DateTime start, DateTime end, int minDiv) async {
    try {
      emit(state.copyWith(state: ExportGenState.exporting));

      final parsed = await _dataRepo.getInterval(
        start: start,
        end: end,
        minDiv: minDiv,
      ) as List;

      final data = parsed.map((e) {
        final time = DateTime.parse(e['time'].toString());
        final powaId = int.parse(e['powadorId'].toString());
        final values = {
          for (var t in Trend.values)
            t: e[t.id] == null ? null : t.parse(e[t.id].toString())
        };
        return Tuple3(time, powaId, values);
      }).toList(growable: false);

      data.sort((a, b) {
        final comp = a.item1.compareTo(b.item1);
        return comp != 0 ? comp : a.item2.compareTo(b.item2);
      });

      if (data.isEmpty) {
        emit(
          state.copyWith(
            state: ExportGenState.exportError,
            ex: 'Empty response!',
          ),
        );
        return;
      }

      final toExport = '${s.powadorId};${s.time};${s.state};'
          '${s.genVoltage};${s.genCurrent};${s.genPower};'
          '${s.netVoltage};${s.netCurrent};${s.netPower};'
          '${s.temperature}\n'
          '${data.map(
                (e) => "${e.item2};"
                    "${e.item1};"
                    "${e.item3[Trend.state]};"
                    "${decimalFormatOne.format(e.item3[Trend.genVoltage])};"
                    "${decimalFormatTwo.format(e.item3[Trend.genCurrent])};"
                    "${e.item3[Trend.genPower]};"
                    "${decimalFormatOne.format(e.item3[Trend.netVoltage])};"
                    "${decimalFormatTwo.format(e.item3[Trend.netCurrent])};"
                    "${e.item3[Trend.netPower]};"
                    "${e.item3[Trend.temperature]}\n",
              ).join("")}';

      emit(
        state.copyWith(
          state: ExportGenState.exported,
          toDownload: AnchorElement(
            href: 'data:application/octet-stream;charset=utf-16le;base64,'
                '${base64Encode(toExport.codeUnits)}',
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(state: ExportGenState.exportError, ex: e));
    }
  }
}
