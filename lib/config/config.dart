import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:powasys_frontend/config/theme_config.dart';

late Box _box;
late ThemeSettings _themeSettings;

Future<void> initConfig() async {
  await Hive.initFlutter();
  _box = await Hive.openBox('settings');
  _themeSettings = ThemeSettings(_box);
}

ThemeSettings get themeSettings => _themeSettings;
