class Language {
  LanguageAction action;
  String locale;
  bool selected;

  Language(this.action, this.locale, this.selected);
}

enum LanguageAction {
  english,
  dutch,
}
