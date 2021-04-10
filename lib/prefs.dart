import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

bool light = true;

Future<void> saveTheme() async {
  final pref = await _prefs;
  pref.setBool('theme', light);
}

Future<void> getTheme() async {
  final lightF = _prefs.then((SharedPreferences prefs) {
    return prefs.getBool('theme') ?? true;
  });
  light = await lightF;
}
