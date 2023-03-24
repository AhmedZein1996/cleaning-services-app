class Language {
  String code;
  String englishName;
  String localName;
  String flag;
  bool selected;

  Language(this.code, this.englishName, this.localName, this.flag,
      {this.selected = false});
}

class LanguagesList {
  List<Language>? _languages;

  LanguagesList() {
    this._languages = [
      Language("en", "English", "English",
          "assets/images/united-states-of-america.png"),
      Language(
          "ar", "Arabic", "العربية", "assets/images/united-arab-emirates.png"),
      Language("es", "Spanish", "Spana", "assets/images/spain.png"),
      Language("fr", "French (France)", "Français - France",
          "assets/images/france.png"),
      Language("fr_CA", "French (Canada)", "Français - Canadien",
          "assets/images/canada.png"),
      Language("pt_BR", "Portugese (Brazil)", "Brazilian",
          "assets/images/brazil.png"),
      Language("ko", "Korean", "Korean",
          "assets/images/united-states-of-america.png"),
      Language("lt", "Lietuvių", "Lietuva", "assets/images/lietuva_flag.png"),
      Language("ru", "Russia", "Россия", "assets/images/russia_flag.png"),
    ];
  }

  List<Language> get languages => _languages!;
}
