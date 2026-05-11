import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/base_state.dart';
import 'package:flutter_boilerplate/features/more/providers/more_provider.dart';
import 'package:flutter_boilerplate/features/more/widgets/more_item.dart';
import 'package:flutter_boilerplate/widgets/line_divider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer';
import 'package:share_plus/share_plus.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends BaseState<MoreScreen> {
  late MoreProvider provider;

  @override
  void initState() {
    super.initState();
    provider = context.read<MoreProvider>();
    // fetch data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.fetchMoreItems(context);
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
    // observe data
    var moreItems = context.watch<MoreProvider>().moreItems;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Row(
            children: [
              Icon(Icons.more, size: 32, color: colorScheme.onSurface),
              const SizedBox(width: 16),
              Text(
                localization.more,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: moreItems.length,
            itemBuilder: (context, index) {
              final item = moreItems[index];
              return MoreItem(
                more: item,
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
        _openSettingsPage();
        break;
      case 1:
        _openFeedbackPage();
        break;
      case 2:
        _openPrivacyPolicy();
        break;
      case 3:
        _openShareApp();
        break;
      case 4:
        _openRateUs();
        break;
      case 5:
        _openMoreApps();
        break;
    }
  }

  void _openSettingsPage() {
    StatefulNavigationShell.of(context).goBranch(1);
  }

  void _openFeedbackPage() {
    StatefulNavigationShell.of(context).goBranch(2);
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
      SharePlus.instance.share(ShareParams(text: localization.share_note));
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
