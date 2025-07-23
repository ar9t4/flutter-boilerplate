import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_boilerplate/l10n/app_localizations.dart';

import '../model/data/local/feedback_item.dart';

class FeedbackProvider extends ChangeNotifier {
  var isInvalid = false;
  var feedbackItems = <FeedbackItem>[];

  void fetchFeedbackItems(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    // clear previous items
    feedbackItems.clear();
    feedbackItems.add(FeedbackItem(1, appLocalizations.improve_design, false));
    feedbackItems
        .add(FeedbackItem(2, appLocalizations.improve_experience, false));
    feedbackItems
        .add(FeedbackItem(3, appLocalizations.improve_functionality, false));
    feedbackItems
        .add(FeedbackItem(4, appLocalizations.improve_performance, false));
    notifyListeners();
  }

  void onItemTap(int index) {
    FeedbackItem item = feedbackItems[index];
    item.isSelected = !item.isSelected;
    feedbackItems[index] = item;
    isInvalid = false;
    notifyListeners();
  }

  void onTextChanged(TextEditingController controller) {
    if (controller.text.trim().isNotEmpty) {
      isInvalid = false;
      notifyListeners();
    }
  }

  void isValid(AppLocalizations appLocalizations, String appName,
      FocusNode focusNode, TextEditingController controller) {
    focusNode.unfocus();
    final selectedItems = feedbackItems.where((element) => element.isSelected);
    if (selectedItems.isEmpty && controller.text.isEmpty) {
      isInvalid = true;
      notifyListeners();
    } else {
      String body = '';
      for (var i = 0; i < selectedItems.length; i++) {
        body += '${i + 1}. ${selectedItems.elementAt(i).name}\n\n';
      }
      if (controller.text.isNotEmpty) {
        body += '\n${appLocalizations.briefly_described_feedback}\n\n';
        body += controller.text;
        body += '\n\n';
      }
      _sendEmail(appLocalizations, appName, body, controller);
    }
  }

  void _sendEmail(AppLocalizations appLocalizations, String appName,
      String body, TextEditingController controller) async {
    final Email email = Email(
      body: body,
      subject: '${appLocalizations.feedback} - $appName',
      recipients: ['test@test.com'],
    );
    String platformResponse;
    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      log('Could not send email ${error.toString()}');
      platformResponse = error.toString();
    }
    log('Feedback email status : $platformResponse');
    _resetStates(controller);
  }

  void _resetStates(TextEditingController controller) {
    controller.clear();
    for (var element in feedbackItems) {
      element.isSelected = false;
    }
    feedbackItems = feedbackItems;
    notifyListeners();
  }
}
