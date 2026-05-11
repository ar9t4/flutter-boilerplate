import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/base_state.dart';
import 'package:flutter_boilerplate/features/languages/widgets/language_item.dart';
import 'package:flutter_boilerplate/features/settings/providers/settings_provider.dart';
import 'package:flutter_boilerplate/widgets/line_divider.dart';
import 'package:provider/provider.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({super.key});
  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends BaseState<LanguagesScreen> {
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
          tooltip: localization.back,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(child: _build()),
    );
  }

  Widget _build() {
    // observe data
    var languageItems = context.watch<SettingsProvider>().languageItems;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Row(
            children: [
              Icon(Icons.language, size: 32, color: colorScheme.onSurface),
              const SizedBox(width: 16),
              Text(
                localization.languages,
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
            itemCount: languageItems.length,
            itemBuilder: (context, index) {
              final language = languageItems[index];
              return LanguageItem(
                language: language,
                onPressed: () => _updateDeviceLanguageSettings(language.locale),
              );
            },
            separatorBuilder: (context, index) => const LineDivider(),
          ),
        ),
      ],
    );
  }

  void _updateDeviceLanguageSettings(String languageCode) {
    provider.updateDeviceLanguageSettings(localization, languageCode);
  }
}
