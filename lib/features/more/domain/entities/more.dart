import 'package:flutter/material.dart';

class More {
  MoreAction action;
  Icon icon;

  More(this.action, this.icon);
}

enum MoreAction {
  settings,
  feedback,
  privacyPolicy,
  share,
  rateUs,
  moreApps,
  version,
}
