import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/pages/users/users.dart';
import 'package:flutter_boilerplate/pages/settings/settings.dart';
import 'package:flutter_boilerplate/pages/feedback/feedback.dart';
import 'package:flutter_boilerplate/pages/more/more.dart';
import 'package:flutter_boilerplate/providers/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = <Widget>[
    const UsersPage(),
    const SettingsPage(),
    const FeedbackPage(),
    const MorePage()
  ];

  @override
  Widget build(BuildContext context) {
    var appProvider = context.watch<AppProvider>();
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    int selectedIndex = appProvider.bottomNavigationSelectedIndex;
     ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(child: pages.elementAt(selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (value) => {appProvider.onBottomNavigationItemSelected(value)},
          type: BottomNavigationBarType.fixed,
          selectedItemColor: colorScheme.onBackground,
          unselectedItemColor: Colors.grey,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: const Icon(Icons.group), label: appLocalizations.users),
            BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: appLocalizations.settings),
            BottomNavigationBarItem(
                icon: const Icon(Icons.feedback),
                label: appLocalizations.feedback),
            BottomNavigationBarItem(
                icon: const Icon(Icons.more), label: appLocalizations.more)
          ]),
    );
  }
}
