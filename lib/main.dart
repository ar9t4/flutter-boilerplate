import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/di/injection.dart';
import 'package:flutter_boilerplate/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:flutter_boilerplate/features/feedback/presentation/providers/feedback_provider.dart';
import 'package:flutter_boilerplate/features/more/domain/repositories/more_repository.dart';
import 'package:flutter_boilerplate/features/settings/domain/repositories/settings_repository.dart';
import 'package:flutter_boilerplate/features/settings/presentation/providers/settings_provider.dart';
import 'package:flutter_boilerplate/features/users/domain/repositories/users_repository.dart';
import 'package:flutter_boilerplate/features/users/presentation/providers/users_provider.dart';
import 'package:flutter_boilerplate/router/app_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_boilerplate/features/more/presentation/providers/more_provider.dart';
import 'package:flutter_boilerplate/l10n/app_localizations.dart';
import 'package:flutter_boilerplate/core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // setup dependencies injections
  await setupDependenciesInjections();
  runApp(App());
}

class App extends StatelessWidget {
  final _router = createGoRoutes();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              UsersProvider(repository: getIt<UsersRepository>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              SettingsProvider(repository: getIt<SettingsRepository>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              FeedbackProvider(repository: getIt<FeedbackRepository>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              MoreProvider(repository: getIt<MoreRepository>()),
        ),
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
