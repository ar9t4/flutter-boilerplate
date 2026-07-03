import 'package:flutter_boilerplate/core/storage/secure_storage.dart';
import 'package:flutter_boilerplate/features/feedback/data/repositories/feedback_repository_impl.dart';
import 'package:flutter_boilerplate/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:flutter_boilerplate/features/more/data/repositories/more_repository_impl.dart';
import 'package:flutter_boilerplate/features/more/domain/repositories/more_repository.dart';
import 'package:flutter_boilerplate/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:flutter_boilerplate/features/settings/domain/repositories/settings_repository.dart';
import 'package:flutter_boilerplate/features/users/data/repositories/users_repository_impl.dart';
import 'package:flutter_boilerplate/features/users/domain/repositories/users_repository.dart';
import 'package:flutter_boilerplate/core/network/dio_service.dart';
import 'package:flutter_boilerplate/core/storage/preferences.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> setupDependenciesInjections() async {
  // service: secure storage
  getIt.registerLazySingleton<SecureStorage>(() => SecureStorage());

  // service: preferences
  getIt.registerSingletonAsync<Preferences>(() async {
    final preferences = Preferences(secureStorage: getIt<SecureStorage>());
    // initialize preferences with default values
    await preferences.init();
    return preferences;
  });

  // service: network client
  getIt.registerLazySingleton<DioService>(() => DioService());

  // repository
  getIt.registerLazySingleton<UsersRepository>(
    () => UsersRepositoryImpl(dio: getIt<DioService>()),
  );

  // repository
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(preferences: getIt<Preferences>()),
  );

  // repository
  getIt.registerLazySingleton<FeedbackRepository>(
    () => FeedbackRepositoryImpl(),
  );

  // repository
  getIt.registerLazySingleton<MoreRepository>(
    () => MoreRepositoryImpl(),
  );

  await getIt.allReady();
}
