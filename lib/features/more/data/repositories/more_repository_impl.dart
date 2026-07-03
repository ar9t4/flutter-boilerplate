import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/features/more/domain/entities/more.dart';
import 'package:flutter_boilerplate/features/more/domain/repositories/more_repository.dart';

class MoreRepositoryImpl implements MoreRepository {
  @override
  List<More> fetchMoreItems() {
    return [
      More(MoreAction.settings, const Icon(Icons.settings)),
      More(MoreAction.feedback, const Icon(Icons.feedback)),
      More(MoreAction.privacyPolicy, const Icon(Icons.privacy_tip)),
      More(MoreAction.share, const Icon(Icons.share)),
      More(MoreAction.rateUs, const Icon(Icons.star)),
      More(MoreAction.moreApps, const Icon(Icons.more)),
      More(MoreAction.version, const Icon(Icons.copy)),
    ];
  }
}
