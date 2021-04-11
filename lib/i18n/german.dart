import 'dart:ui';

import 'package:powasys_frontend/i18n/i18n.dart';

const Map<String, String> _dict = {
  'app_name': 'PowaSys Frontend',
  'copyright': '\u00a9 2021 Nico Mexis',
  'home': 'Startseite',
  'imprint': 'Impressum',
  'contact': 'Kontakt',
  'license': 'Lizenzen',
  'voltage': 'Spannung',
  'current': 'Stärke',
  'power': 'Leistung',
  'temperature': 'Temperatur',
  'currently': 'Derzeit (%s):',
  'average': 'Durchschnitt:',
  'amount_format': '%s %s',
  'voltage_unit': 'V',
  'current_unit': 'A',
  'power_unit': 'W',
  'temperature_unit': '°C',
  'switch_theme': 'Thema wechseln',
  'refresh': 'Neu laden',
};

class German extends Language {
  static const CODE = 'de';
  static const LOCALE = Locale(CODE);
  static const NAME = 'Deutsch';
  static const FLAG = 'de';

  const German() : super(_dict, CODE, LOCALE, NAME, FLAG);
}
