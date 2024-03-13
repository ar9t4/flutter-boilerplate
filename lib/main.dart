import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/providers/feedback_provider.dart';
import 'package:flutter_boilerplate/providers/settings_provider.dart';
import 'package:flutter_boilerplate/providers/users_provider.dart';
import 'package:flutter_boilerplate/storage/preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_boilerplate/pages/home/home.dart';
import 'package:flutter_boilerplate/providers/app_provider.dart';
import 'package:flutter_boilerplate/providers/more_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_boilerplate/utils/color_schemes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize preferences with default values
  Preferences preferences = Preferences();
  await preferences.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppProvider()),
          ChangeNotifierProvider(create: (context) => UsersProvider()),
          ChangeNotifierProvider(create: (context) => SettingsProvider(context)),
          ChangeNotifierProvider(create: (context) => FeedbackProvider()),
          ChangeNotifierProvider(create: (context) => MoreProvider()),
        ],
        child: Consumer<SettingsProvider>(
            builder: (context, settingsProvider, child) {
          return MaterialApp(
              title: 'BoilerPlate',
              theme:
                  ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
              darkTheme:
                  ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
              themeMode: settingsProvider.themeMode,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              supportedLocales: const [Locale('en'), Locale('nl')],
              locale: settingsProvider.locale,
              home: const HomePage());
        }));
  }
}
