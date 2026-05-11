import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/features/feedback/providers/feedback_provider.dart';
import 'package:flutter_boilerplate/features/settings/providers/settings_provider.dart';
import 'package:flutter_boilerplate/features/users/providers/users_provider.dart';
import 'package:flutter_boilerplate/router/app_router.dart';
import 'package:flutter_boilerplate/storage/preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_boilerplate/features/more/providers/more_provider.dart';
import 'package:flutter_boilerplate/l10n/app_localizations.dart';
import 'package:flutter_boilerplate/core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize preferences with default values
  Preferences preferences = Preferences();
  await preferences.init();
  runApp(App());
}

class App extends StatelessWidget {
  final _router = createGoRoutes();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UsersProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider(context)),
        ChangeNotifierProvider(create: (context) => FeedbackProvider()),
        ChangeNotifierProvider(create: (context) => MoreProvider()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return MaterialApp.router(
            routerConfig: _router,
            title: 'BoilerPlate',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settingsProvider.themeMode,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: const [Locale('en'), Locale('nl')],
            locale: settingsProvider.locale,
          );
        },
      ),
    );
  }
}
