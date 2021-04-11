import 'package:powasys_frontend/i18n/i18n.dart';

const Map<String, String> _lang = {
  'app_name': 'PowaSys Frontend',
  'copyright': '\u00a9 2021 %s',
  'license': 'Licenses',
  'voltage': 'Voltage',
  'current': 'Current',
  'power': 'Power',
  'temperature': 'Temperature',
  'currently': 'Derzeit (%s):',
  'average': 'Average:',
  'amount_format': '%s %s',
  'voltage_unit': 'V',
  'current_unit': 'A',
  'power_unit': 'W',
  'temperature_unit': '°C',
};

class English extends Language {
  const English() : super(_lang);
}
