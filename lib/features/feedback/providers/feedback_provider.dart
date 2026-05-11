import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/utils/app_utils.dart';
import 'package:flutter_boilerplate/features/feedback/models/user_feedback.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_boilerplate/l10n/app_localizations.dart';

class FeedbackProvider extends ChangeNotifier {
  var isInvalid = false;
  var feedbackItems = <UserFeedback>[];

  Future<void> fetchFeedbackItems(BuildContext context) async {
    AppLocalizations localization = AppLocalizations.of(context);
    // clear previous items
    feedbackItems.clear();
    await Future.delayed(const Duration(milliseconds: 250));
    feedbackItems.add(UserFeedback(1, localization.improve_design, false));
    feedbackItems.add(UserFeedback(2, localization.improve_experience, false));
    feedbackItems
        .add(UserFeedback(3, localization.improve_functionality, false));
    feedbackItems.add(UserFeedback(4, localization.improve_performance, false));
    notifyListeners();
  }

  void onItemTap(int index) {
    final item = feedbackItems[index];
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

  void isValid(AppLocalizations localization, FocusNode focusNode,
      TextEditingController controller) async {
    focusNode.unfocus();
    final appName = await AppUtils.getAppName();
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
        body += '\n${localization.briefly_described_feedback}\n\n';
        body += controller.text;
        body += '\n\n';
      }
      _sendEmail(localization, appName, body, controller);
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
