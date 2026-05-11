import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/base_state.dart';
import 'package:flutter_boilerplate/core/resources/app_assets.dart';
import 'package:flutter_boilerplate/features/feedback/providers/feedback_provider.dart';
import 'package:flutter_boilerplate/features/feedback/widgets/feedback_item.dart';
import 'package:flutter_boilerplate/widgets/circular_progress_bar.dart';
import 'package:provider/provider.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends BaseState<FeedbackScreen> {
  late FeedbackProvider provider;
  late TextEditingController controller;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    provider = context.read<FeedbackProvider>();
    controller = TextEditingController();
    focusNode = FocusNode(canRequestFocus: false);
    // fetch data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.fetchFeedbackItems(context);
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
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(child: _build()),
    );
  }

  Widget _build() {
    var width = MediaQuery.of(context).size.width;
    // observe data
    var isInvalid = context.watch<FeedbackProvider>().isInvalid;
    var feedbackItems = context.watch<FeedbackProvider>().feedbackItems;
    if (feedbackItems.isEmpty) {
      return const Center(child: CircularProgressBar());
    }
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            child: Row(
              children: [
                Icon(Icons.feedback, size: 32, color: colorScheme.onSurface),
                const SizedBox(width: 16),
                Text(
                  localization.feedback,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface),
                ),
              ],
            ),
          ),
          Image.asset(
            AppAssets.images.feedback(context),
            width: 400,
            height: 200,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localization.give_feedback,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    localization.how_we_can_improve,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface),
                  ),
                ],
              ),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: isOrientationLandscape ? 4 : 2,
            children: List.generate(
              4,
              (index) {
                final feedback = feedbackItems[index];
                return FeedbackItem(
                  feedback: feedback,
                  onPressed: () => provider.onItemTap(index),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                localization.briefly_describe_feedback,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(8),
              ),
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
                    border: InputBorder.none, hintText: localization.type_here),
                onChanged: (value) => {
                  provider.onTextChanged(controller),
                },
              ),
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
                      Text(localization.submit_feedback_validation_note,
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
                        overlayColor: WidgetStateProperty.all(Colors.grey),
                        backgroundColor:
                            WidgetStateProperty.all(colorScheme.onSurface)),
                    child: Text(
                      localization.submit_feedback,
                      style: TextStyle(
                          fontSize: 16,
                          color: colorScheme.surface,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () =>
                        provider.isValid(localization, focusNode, controller),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
