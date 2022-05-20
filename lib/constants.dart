import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:powasys_frontend/data/trend.dart';

String get apiBaseUrl => dotenv.env['APIBaseURL']!;

late PackageInfo packageInfo;

// Cached Settings which should be gone after reloading
List<int> disabledPowadors = [];
Trend currentTrend = Trend.netPower;
int minDiv = 10;
