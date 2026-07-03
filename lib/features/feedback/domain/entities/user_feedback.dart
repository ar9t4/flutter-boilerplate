class UserFeedback {
  UserFeedbackAction action;
  bool isSelected;

  UserFeedback(this.action, this.isSelected);
}

enum UserFeedbackAction {
  improveDesign,
  improveExperience,
  improveFunctionality,
  improvePerformance
}
