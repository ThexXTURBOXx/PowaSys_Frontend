import 'package:flutter_dotenv/flutter_dotenv.dart';

String get apiBaseUrl => dotenv.env['APIBaseURL']!;
