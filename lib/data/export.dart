import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powasys_frontend/bloc/cubits/export_cubit.dart';
import 'package:powasys_frontend/bloc/states.dart';
import 'package:powasys_frontend/constants.dart';
import 'package:powasys_frontend/generated/l10n.dart';
import 'package:powasys_frontend/util/math.dart';

Future<DateTime?> showFullDatePicker({
  required BuildContext context,
  required DateTime initialDate,
}) => showDatePicker(
  context: context,
  initialDate: initialDate,
  firstDate: DateTime.fromMillisecondsSinceEpoch(0),
  lastDate: DateTime.now(),
);

void showExportDialog(BuildContext context, DataState state) {
  final minDivController = TextEditingController(text: '$minDivExport');
  final startController = TextEditingController(
    text: startDateExport.toIso8601String(),
  );
  final endController = TextEditingController(
    text: endDateExport.toIso8601String(),
  );
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(S.of(context).export),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: startController,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              labelText: S.of(context).start_date,
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_month_outlined),
                onPressed: () =>
                    showFullDatePicker(
                      context: context,
                      initialDate: DateTime.now().subtract(
                        const Duration(days: 1),
                      ),
                    ).then((date) {
                      if (date != null) {
                        startController.text = date.atStartOfDay
                            .toIso8601String();
                      }
                    }),
              ),
            ),
          ),
          TextField(
            controller: endController,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              labelText: S.of(context).end_date,
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_month_outlined),
                onPressed: () =>
                    showFullDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                    ).then((date) {
                      if (date != null) {
                        endController.text = date.atEndOfDay.toIso8601String();
                      }
                    }),
              ),
            ),
          ),
          TextField(
            controller: minDivController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              labelText: S.of(context).minute_divider,
            ),
          ),
          MaterialButton(
            child: Text(S.of(context).export),
            onPressed: () {
              Navigator.pop(context);
              startDateExport = DateTime.parse(startController.text);
              endDateExport = DateTime.parse(endController.text);
              minDivExport = int.parse(minDivController.text);
              context.read<ExportCubit>().exportData(
                S.of(context),
                startDateExport,
                endDateExport,
                minDivExport,
              );
            },
          ),
        ],
      ),
    ),
  );
}
