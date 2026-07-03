import 'package:flutter_boilerplate/features/feedback/domain/entities/user_feedback.dart';
import 'package:flutter_boilerplate/features/feedback/domain/repositories/feedback_repository.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  @override
  List<UserFeedback> fetchFeedbackItems() {
    return [
      UserFeedback(UserFeedbackAction.improveDesign, false),
      UserFeedback(UserFeedbackAction.improveExperience, false),
      UserFeedback(UserFeedbackAction.improveFunctionality, false),
      UserFeedback(UserFeedbackAction.improvePerformance, false),
    ];
  }
}
