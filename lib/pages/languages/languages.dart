import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguagesPage extends StatefulWidget {
  const LanguagesPage({super.key});
  @override
  State<LanguagesPage> createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  late SettingsProvider settingsState;
  late AppLocalizations appLocalizations;

  @override
  void initState() {
    super.initState();
    settingsState = Provider.of<SettingsProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);
    // observe data
    var languageItems = context.watch<SettingsProvider>().languageItems;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.background,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: colorScheme.onBackground),
            tooltip: appLocalizations.back,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: Row(children: [
                  Icon(Icons.language,
                      size: 32, color: colorScheme.onBackground),
                  const SizedBox(width: 16),
                  Text(appLocalizations.languages,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onBackground))
                ])),
            Expanded(
                child: ListView.separated(
              itemCount: languageItems.length,
              itemBuilder: (context, index) {
                final item = languageItems[index];
                return ListTile(
                  key: Key(item.id.toString()),
                  dense: true,
                  title: Text(item.name, style: const TextStyle(fontSize: 14)),
                  trailing: item.selected
                      ? const Icon(Icons.check_circle, size: 24)
                      : const Icon(Icons.check_circle_outline, size: 24),
                  contentPadding: const EdgeInsets.only(left: 16, right: 16),
                  visualDensity:
                      const VisualDensity(horizontal: -2, vertical: 2),
                  iconColor: colorScheme.onBackground,
                  textColor: colorScheme.onBackground,
                  onTap: () {
                    _updateDeviceLanguageSettings(
                        appLocalizations, item.locale);
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

  void _updateDeviceLanguageSettings(
      AppLocalizations appLocalizations, String languageCode) {
    settingsState.updateDeviceLanguageSettings(appLocalizations, languageCode);
  }
}
