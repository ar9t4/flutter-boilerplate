import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/pages/languages/languages.dart';
import 'package:flutter_boilerplate/pages/themes/themes.dart';
import 'package:flutter_boilerplate/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsProvider settingsState;
  late AppLocalizations appLocalizations;

  @override
  void initState() {
    super.initState();
    settingsState = Provider.of<SettingsProvider>(context, listen: false);
    // fetch data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      settingsState.fetchSettingsItems(appLocalizations);
    });
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);
    // fetch data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (settingsState.isLocaleUpdated) {
        settingsState.fetchSettingsItems(appLocalizations);
      }
    });
    // observe data
    var settingsItems = context.watch<SettingsProvider>().settingsItems;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            child: Row(children: [
              Icon(Icons.settings, size: 32, color: colorScheme.onBackground),
              const SizedBox(width: 16),
              Text(appLocalizations.settings,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onBackground))
            ])),
        Expanded(
            child: ListView.separated(
          itemCount: settingsItems.length,
          itemBuilder: (context, index) {
            final item = settingsItems[index];
            return ListTile(
              key: Key(item.id.toString()),
              dense: true,
              leading: item.icon,
              title: Text(item.key, style: const TextStyle(fontSize: 14)),
              subtitle: Text(
                  index == 0
                      ? item.value == true.toString()
                          ? appLocalizations.on
                          : appLocalizations.off
                      : item.value,
                  style: const TextStyle(fontSize: 14)),
              trailing: index == 0
                  ? Transform.scale(
                      scale: 0.65,
                      alignment: Alignment.centerRight,
                      child: Switch(
                          value: (item.value == true.toString() ? true : false),
                          onChanged: (value) =>
                              {_toggleNotificationsSettings(appLocalizations)},
                          thumbColor:
                              MaterialStateProperty.all(colorScheme.surface),
                          trackColor:
                              MaterialStateProperty.all(colorScheme.onSurface)))
                  : const Icon(Icons.arrow_circle_right_outlined, size: 24),
              contentPadding: const EdgeInsets.only(left: 16, right: 16),
              visualDensity: const VisualDensity(horizontal: -2, vertical: 2),
              iconColor: colorScheme.onBackground,
              textColor: colorScheme.onBackground,
              onTap: () => {
                if (index == 0)
                  {_toggleNotificationsSettings(appLocalizations)}
                else if (index == 1)
                  {_openThemeSettings()}
                else
                  {_openLanguageSettings()}
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
                height: 0, thickness: 0, color: colorScheme.onBackground);
          },
        ))
      ],
    )));
  }

  void _toggleNotificationsSettings(AppLocalizations appLocalizations) {
    settingsState.toggleNotificationsSettings(appLocalizations);
  }

  void _openThemeSettings() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ThemesPage(),
    ));
  }

  void _openLanguageSettings() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LanguagesPage(),
    ));
  }
}
