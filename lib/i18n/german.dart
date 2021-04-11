import 'package:powasys_frontend/i18n/i18n.dart';

const Map<String, String> _lang = {
  'app_name': 'PowaSys Frontend',
  'copyright': '\u00a9 2021 %s',
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
};

class German extends Language {
  const German() : super(_lang);
}
