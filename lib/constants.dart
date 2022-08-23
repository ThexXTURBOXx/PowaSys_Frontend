import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:powasys_frontend/data/trend.dart';

String get apiBaseUrl => dotenv.env['APIBaseURL']!;

String get apiEndpointPowas => dotenv.env['APIEndpointPowas']!;

String get apiEndpoint24h => dotenv.env['APIEndpoint24h']!;

late PackageInfo packageInfo;

// Cached Settings which should be gone after reloading
List<int> disabledPowadors = [];
Trend currentTrend = Trend.netPower;
int minDiv = 10;
