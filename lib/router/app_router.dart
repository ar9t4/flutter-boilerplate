import 'package:flutter_boilerplate/app/main_scaffold.dart';
import 'package:flutter_boilerplate/features/feedback/screens/feedback_screen.dart';
import 'package:flutter_boilerplate/features/languages/screens/languages_screen.dart';
import 'package:flutter_boilerplate/features/more/screens/more_screen.dart';
import 'package:flutter_boilerplate/features/settings/screens/settings_screen.dart';
import 'package:flutter_boilerplate/features/themes/screens/themes_screen.dart';
import 'package:flutter_boilerplate/features/users/screens/user_details_screen.dart';
import 'package:flutter_boilerplate/features/users/screens/users_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter createGoRoutes() {
  return GoRouter(
    initialLocation: '/users',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          // tab 1: users
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/users',
                builder: (context, state) => const UsersScreen(),
                routes: [
                  GoRoute(
                    path: 'detail/:email',
                    builder: (context, state) {
                      final email = Uri.decodeComponent(
                        state.pathParameters['email'] ?? '',
                      );
                      return UserDetailsScreen(email: email);
                    },
                  ),
                ],
              ),
            ],
          ),
          // tab 2: settings
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
                routes: [
                  GoRoute(
                    path: 'themes',
                    builder: (context, state) => const ThemesScreen(),
                  ),
                  GoRoute(
                    path: 'languages',
                    builder: (context, state) => const LanguagesScreen(),
                  ),
                ],
              ),
            ],
          ),
          // tab 3: feedback
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/feedback',
                builder: (context, state) => const FeedbackScreen(),
              ),
            ],
          ),
          // tab 4: more
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/more',
                builder: (context, state) => const MoreScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
