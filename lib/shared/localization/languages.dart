class Languages {
  int id;
  String name;
  String flag;
  String languageCode;
  Languages(this.id, this.name, this.flag, this.languageCode);

  static List<Languages> languages = [
    Languages(1, "english", "en", "en"),
    Languages(2, "urdu", "pk", "ur"),
    Languages(3, "hindi", "in", "hi"),
    Languages(4, "bengali", "bn", "bn"),
    Languages(5, "arabic", "ar", "ar"),
    Languages(6, "chinese", "cz", "zh"),
    Languages(7, "french", "fr", "fr"),
    Languages(8, "indonesian", "id", "id"),
    Languages(9, "spanish", "es", "es"),
    Languages(10, "german", "gr", "de"),
  ];
}
