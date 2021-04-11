import 'dart:ui';

import 'package:powasys_frontend/i18n/i18n.dart';

const Map<String, String> _dict = {
  'app_name': 'PowaSys Frontend',
  'copyright': '\u00a9 2021 Nico Mexis',
  'home': 'Home',
  'imprint': 'Imprint',
  'contact': 'Contact',
  'license': 'Licenses',
  'voltage': 'Voltage',
  'current': 'Current',
  'power': 'Power',
  'temperature': 'Temperature',
  'currently': 'Currently (%s):',
  'average': 'Average:',
  'amount_format': '%s %s',
  'voltage_unit': 'V',
  'current_unit': 'A',
  'power_unit': 'W',
  'temperature_unit': '°C',
  'switch_theme': 'Switch theme',
};

class English extends Language {
  static const CODE = 'en';
  static const LOCALE = Locale(CODE);
  static const NAME = 'English';
  static const FLAG = 'gb';

  const English() : super(_dict, CODE, LOCALE, NAME, FLAG);
}
