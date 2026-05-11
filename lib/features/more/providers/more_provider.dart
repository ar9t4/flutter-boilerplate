import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/l10n/app_localizations.dart';
import '../models/more.dart';

class MoreProvider extends ChangeNotifier {
  var moreItems = <More>[];

  void fetchMoreItems(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context);
    // clear previous items
    moreItems.clear();
    moreItems.add(More(1, localization.settings, const Icon(Icons.settings)));
    moreItems.add(More(2, localization.feedback, const Icon(Icons.feedback)));
    moreItems.add(
        More(3, localization.privacy_policy, const Icon(Icons.privacy_tip)));
    moreItems.add(More(4, localization.share, const Icon(Icons.share)));
    moreItems.add(More(5, localization.rate_us, const Icon(Icons.star)));
    moreItems.add(More(6, localization.more_apps, const Icon(Icons.more)));
    moreItems.add(More(7, localization.version, const Icon(Icons.copy)));
    notifyListeners();
  }
}
