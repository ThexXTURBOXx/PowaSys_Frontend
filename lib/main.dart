import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:powasys_frontend/bloc/cubits/data_cubit.dart';
import 'package:powasys_frontend/bloc/repos/data_repo.dart';
import 'package:powasys_frontend/config/config.dart';
import 'package:powasys_frontend/constants.dart';
import 'package:powasys_frontend/generated/l10n.dart';
import 'package:powasys_frontend/pages/home.dart';
import 'package:powasys_frontend/themes/dark_theme.dart';
import 'package:powasys_frontend/themes/light_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await initConfig();
  packageInfo = await PackageInfo.fromPlatform();
  runApp(const PowaSysFrontendWidget());
}

class PowaSysFrontendWidget extends StatefulWidget {
  const PowaSysFrontendWidget({super.key});

  @override
  State<StatefulWidget> createState() => _PowaSysFrontendWidgetState();
}

class _PowaSysFrontendWidgetState extends State<PowaSysFrontendWidget> {
  @override
  void initState() {
    super.initState();
    themeSettings.addListener(() => setState(() {}));
    localeSettings.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<DataRepo>(
            create: (context) => DataRepo(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<DataCubit>(
              create: (context) => DataCubit(context.read<DataRepo>()),
            ),
          ],
          child: MaterialApp(
            onGenerateTitle: (context) => S.of(context).app_name,
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeSettings.currentTheme,
            locale: localeSettings.currentLocale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            initialRoute: routeHome,
            routes: {
              routeHome: (context) => Home(packageInfo),
            },
          ),
        ),
      );
}
