import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../model/data/local/more_item.dart';

class MoreProvider extends ChangeNotifier {
  var moreItems = <MoreItem>[];

  void fetchMoreItems(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    // clear previous items
    moreItems.clear();
    moreItems.add(
        MoreItem(1, appLocalizations.settings, const Icon(Icons.settings)));
    moreItems.add(
        MoreItem(2, appLocalizations.feedback, const Icon(Icons.feedback)));
    moreItems.add(MoreItem(
        3, appLocalizations.privacy_policy, const Icon(Icons.privacy_tip)));
    moreItems.add(MoreItem(4, appLocalizations.share, const Icon(Icons.share)));
    moreItems
        .add(MoreItem(5, appLocalizations.rate_us, const Icon(Icons.star)));
    moreItems
        .add(MoreItem(6, appLocalizations.more_apps, const Icon(Icons.more)));
    moreItems
        .add(MoreItem(7, appLocalizations.version, const Icon(Icons.copy)));
    notifyListeners();
  }
}
