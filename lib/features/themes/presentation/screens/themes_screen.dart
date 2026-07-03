import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/base/base_state.dart';
import 'package:flutter_boilerplate/features/settings/presentation/providers/settings_provider.dart';
import 'package:flutter_boilerplate/features/themes/presentation/widgets/theme_item.dart';
import 'package:flutter_boilerplate/core/widgets/line_divider.dart';
import 'package:provider/provider.dart';

class ThemesScreen extends StatefulWidget {
  const ThemesScreen({super.key});
  @override
  State<ThemesScreen> createState() => _ThemesScreenState();
}

class _ThemesScreenState extends BaseState<ThemesScreen> {
  late SettingsProvider provider;

  @override
  void initState() {
    super.initState();
    provider = context.read<SettingsProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          tooltip: l10n.back,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(child: _build()),
    );
  }

  Widget _build() {
    // observe data
    var themeItems = context.watch<SettingsProvider>().themeItems;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Row(
            children: [
              Icon(Icons.dark_mode, size: 32, color: colorScheme.onSurface),
              const SizedBox(width: 16),
              Text(
                l10n.themes,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: themeItems.length,
            itemBuilder: (context, index) {
              final theme = themeItems[index];
              return ThemeItem(
                  theme: theme,
                  onPressed: () => _updateDeviceThemeSettings(theme.code));
            },
            separatorBuilder: (context, index) => const LineDivider(),
          ),
        ),
      ],
    );
  }

  void _updateDeviceThemeSettings(String themeCode) {
    provider.updateDeviceThemeSettings(context, l10n, themeCode);
  }
}
