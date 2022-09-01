import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:powasys_frontend/data/trend.dart';
import 'package:powasys_frontend/util/math.dart';

String get apiBaseUrl => dotenv.env['APIBaseURL']!;

String get apiEndpointPowas => dotenv.env['APIEndpointPowas']!;

String get apiEndpoint24h => dotenv.env['APIEndpoint24h']!;

String get apiEndpointInterval => dotenv.env['APIEndpointInterval']!;

late PackageInfo packageInfo;

final decimalFormatOne = NumberFormat('##0.0');

final decimalFormatTwo = NumberFormat('##0.00');

// Cached Settings which should be gone after reloading
List<int> disabledPowadors = [];
Trend currentTrend = Trend.netPower;
int minDiv = 10;
DateTime startDateExport = DateTime.now().atStartOfDay;
DateTime endDateExport = DateTime.now().atEndOfDay;
int minDivExport = 10;

String formatNum(BuildContext context, num? value) {
  if (value == null) {
    return '';
  } else if (value is int) {
    return '$value';
  } else {
    return decimalFormatTwo.format(value);
  }
}
