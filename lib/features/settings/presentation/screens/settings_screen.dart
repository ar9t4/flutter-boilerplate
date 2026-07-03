import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/base/base_state.dart';
import 'package:flutter_boilerplate/features/settings/presentation/widgets/settings_item.dart';
import 'package:flutter_boilerplate/features/settings/presentation/providers/settings_provider.dart';
import 'package:flutter_boilerplate/core/widgets/line_divider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_boilerplate/l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseState<SettingsScreen> {
  late SettingsProvider provider;

  @override
  void initState() {
    super.initState();
    provider = context.read<SettingsProvider>();
    // fetch data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.fetchSettingsItems(context, l10n);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(child: _build()),
    );
  }

  Widget _build() {
    // fetch data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (provider.isLocaleUpdated) {
        provider.fetchSettingsItems(context, l10n);
      }
    });
    // observe data
    var settingsItems = context.watch<SettingsProvider>().settingsItems;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Row(
            children: [
              Icon(Icons.settings, size: 32, color: colorScheme.onSurface),
              const SizedBox(width: 16),
              Text(
                l10n.settings,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: settingsItems.length,
            itemBuilder: (context, index) {
              final settings = settingsItems[index];
              return SettingsItem(
                settings: settings,
                onChanged: (value) => _toggleNotificationsSettings(l10n),
                onPressed: () => _onItemPressed(index),
              );
            },
            separatorBuilder: (context, index) => const LineDivider(),
          ),
        ),
      ],
    );
  }

  void _onItemPressed(int index) {
    switch (index) {
      case 0:
        _toggleNotificationsSettings(l10n);
        break;
      case 1:
        _openThemeSettings();
        break;
      default:
        _openLanguageSettings();
        break;
    }
  }

  void _toggleNotificationsSettings(AppLocalizations l10n) {
    provider.toggleNotificationsSettings(l10n);
  }

  void _openThemeSettings() {
    context.push('$route/themes');
  }

  void _openLanguageSettings() {
    context.push('$route/languages');
  }
}
