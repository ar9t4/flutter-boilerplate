import 'package:flutter_boilerplate/features/feedback/domain/entities/user_feedback.dart';

abstract interface class FeedbackRepository {
  List<UserFeedback> fetchFeedbackItems();
}