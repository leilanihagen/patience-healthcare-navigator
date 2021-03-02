class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇺🇸", "English", "EN"),
      Language(2, "🇲🇽", "Español‎", "ES"),
      Language(3, "🇻🇳", "Tiếng việt", "VI"),
      Language(4, "🇰🇷", "한국어", "KR")
    ];
  }
}
