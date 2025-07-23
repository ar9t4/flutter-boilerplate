import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/providers/app_provider.dart';
import 'package:flutter_boilerplate/providers/feedback_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_boilerplate/l10n/app_localizations.dart';

import '../../model/data/local/feedback_item.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  late AppProvider appProvider;
  late FeedbackProvider feedbackProvider;
  late TextEditingController controller;
  late FocusNode focusNode;
  late AppLocalizations appLocalizations;

  @override
  void initState() {
    super.initState();
    appProvider = Provider.of<AppProvider>(context, listen: false);
    feedbackProvider = Provider.of<FeedbackProvider>(context, listen: false);
    controller = TextEditingController();
    focusNode = FocusNode(canRequestFocus: false);
    // fetch data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      feedbackProvider.fetchFeedbackItems(context);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);
    var width = MediaQuery.of(context).size.width;
    // observe data
    var isInvalid = context.watch<FeedbackProvider>().isInvalid;
    var feedbackItems = context.watch<FeedbackProvider>().feedbackItems;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: Row(children: [
                  Icon(Icons.feedback,
                      size: 32, color: colorScheme.onSurface),
                  const SizedBox(width: 16),
                  Text(appLocalizations.feedback,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface))
                ])),
            Image.asset('assets/images/feedback.webp', width: 400, height: 200),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(appLocalizations.give_feedback,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface)),
                        const SizedBox(height: 8),
                        Text(appLocalizations.how_we_can_improve,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface)),
                      ],
                    ))),
            GridView.count(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 2,
              children: List.generate(4, (index) {
                FeedbackItem item = feedbackItems[index];
                return InkWell(
                  onTap: () => {feedbackProvider.onItemTap(index)},
                  child: Ink(
                      decoration: BoxDecoration(
                          color: item.isSelected
                              ? colorScheme.onSurface
                              : colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(item.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: item.isSelected
                                    ? colorScheme.surface
                                    : colorScheme.surfaceContainerHighest,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      )),
                );
              }),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(appLocalizations.briefly_describe_feedback,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface)),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                decoration: BoxDecoration(
                    color: colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(8)),
                child: TextField(
                    autofocus: false,
                    autocorrect: false,
                    focusNode: focusNode,
                    cursorColor: colorScheme.surfaceContainerHighest,
                    cursorHeight: 20,
                    maxLines: 5,
                    controller: controller,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: appLocalizations.type_here),
                    onChanged: (value) =>
                        {feedbackProvider.onTextChanged(controller)}),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  children: [
                    if (isInvalid) ...[
                      Column(
                        children: [
                          Text(appLocalizations.submit_feedback_validation_note,
                              style: const TextStyle(color: Colors.red)),
                          const SizedBox(height: 16),
                        ],
                      )
                    ],
                    SizedBox(
                        width: width,
                        height: 48,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                overlayColor:
                                    WidgetStateProperty.all(Colors.grey),
                                backgroundColor: WidgetStateProperty.all(
                                    colorScheme.onSurface)),
                            child: Text(appLocalizations.submit_feedback,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: colorScheme.surface,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () => {
                                  feedbackProvider.isValid(
                                      appLocalizations,
                                      appProvider.appName,
                                      focusNode,
                                      controller)
                                }))
                  ],
                )),
            const SizedBox(height: 32),
          ],
        ),
      )),
    );
  }
}
