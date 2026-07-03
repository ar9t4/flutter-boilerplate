import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/base/base_stateless.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends BaseStatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = getColorScheme(context);
    final l10n = getLocalization(context);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          // prevents rebuilding stacks unnecessarily
          final initialLocation = index == navigationShell.currentIndex;
          navigationShell.goBranch(index, initialLocation: initialLocation);
        },
        currentIndex: navigationShell.currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorScheme.onSurface,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: l10n.users,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: l10n.settings,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: l10n.feedback,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more),
            label: l10n.more,
          ),
        ],
      ),
    );
  }
}
