import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/providers/app_provider.dart';
import 'package:flutter_boilerplate/providers/more_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_boilerplate/l10n/app_localizations.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  late AppProvider appProvider;
  late MoreProvider moreProvider;
  late AppLocalizations appLocalizations;

  @override
  void initState() {
    super.initState();
    appProvider = Provider.of<AppProvider>(context, listen: false);
    moreProvider = Provider.of<MoreProvider>(context, listen: false);
    // fetch data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      moreProvider.fetchMoreItems(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);
    // observe data
    var moreItems = context.watch<MoreProvider>().moreItems;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            child: Row(children: [
              Icon(Icons.more, size: 32, color: colorScheme.onSurface),
              const SizedBox(width: 16),
              Text(appLocalizations.more,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface))
            ])),
        Expanded(
            child: ListView.separated(
          itemCount: moreItems.length,
          itemBuilder: (context, index) {
            final item = moreItems[index];
            return ListTile(
              key: Key(item.id.toString()),
              dense: true,
              leading: item.icon,
              title: Text(item.name, style: const TextStyle(fontSize: 14)),
              trailing: index == (moreItems.length - 1)
                  ? Text(appProvider.appVersion,
                      style: const TextStyle(fontSize: 12))
                  : const Icon(Icons.arrow_circle_right_outlined, size: 24),
              contentPadding: const EdgeInsets.only(left: 16, right: 16),
              visualDensity: const VisualDensity(horizontal: -2, vertical: 2),
              iconColor: colorScheme.onSurface,
              textColor: colorScheme.onSurface,
              onTap: () => {
                if (index == 0)
                  {_openSettingsPage()}
                else if (index == 1)
                  {_openFeedbackPage()}
                else if (index == 2)
                  {_openPrivacyPolicy()}
                else if (index == 3)
                  {_openShareApp()}
                else if (index == 4)
                  {_openRateUs()}
                else if (index == 5)
                  {_openMoreApps()}
                else
                  {}
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
                height: 0, thickness: 0, color: colorScheme.onSurface);
          },
        ))
      ],
    )));
  }

  void _openSettingsPage() {
    appProvider.onBottomNavigationItemSelected(1);
  }

  void _openFeedbackPage() {
    appProvider.onBottomNavigationItemSelected(2);
  }

  void _openPrivacyPolicy() {
    Uri uri = Uri(scheme: 'https', host: 'www.google.com');
    _launchInBrowser(uri);
  }

  void _launchInBrowser(Uri uri) async {
    try {
      bool result = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!result) {
        log('Could not launch $uri');
      }
    } catch (e) {
      log('Could not launch $uri');
    }
  }

  void _openShareApp() {
    try {
      SharePlus.instance.share(ShareParams(text: appLocalizations.share_note));
    } catch (e) {
      log('Could not launch platform share');
    }
  }

  void _openRateUs() {
    if (Platform.isAndroid || Platform.isIOS) {
      final appId = Platform.isAndroid ? 'com.whatsapp' : '310633997';
      final uri = Uri.parse(Platform.isAndroid
          ? 'https://play.google.com/store/apps/details?id=$appId'
          : 'https://apps.apple.com/app/id$appId');
      _launchInBrowser(uri);
    }
  }

  void _openMoreApps() {
    if (Platform.isAndroid || Platform.isIOS) {
      final storeId =
          Platform.isAndroid ? 'WhatsApp LLC' : 'whatsapp-inc/id310634000';
      final uri = Uri.parse(Platform.isAndroid
          ? 'https://play.google.com/store/search?q=pub:$storeId'
          : 'https://apps.apple.com/developer/$storeId');
      _launchInBrowser(uri);
    }
  }
}
