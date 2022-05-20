import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';

String get apiBaseUrl => dotenv.env['APIBaseURL']!;

late PackageInfo packageInfo;
