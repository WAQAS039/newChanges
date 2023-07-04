class LastSeen {
  String? _surahNameArabic;
  String? _surahName;
  String? _surahEnglish;
  String? _juzArabic;
  int? _surahId;
  int? _ayahId;
  int? _lastSeen;
  bool? _isJuz;
  int? _juzId;

  String? get surahNameArabic => _surahNameArabic;

  String? get surahName => _surahName;

  String? get surahEnglish => _surahEnglish;

  String? get juzArabic => _juzArabic;

  int? get surahId => _surahId;

  int? get ayahId => _ayahId;

  int? get lastSeen => _lastSeen;

  bool? get isJuz => _isJuz;

  int? get juzId => _juzId;

  LastSeen(
      {required surahNameArabic,
      required surahName,
      required surahEnglish,
      required juzName,
      required surahId,
      required ayahId,
      required lastSeen,
      required isJuz,
        required juzId,
      }) {
    _surahNameArabic = surahNameArabic;
    _surahName = surahName;
    _surahEnglish = surahEnglish;
    _surahId = surahId;
    _ayahId = ayahId;
    _lastSeen = lastSeen;
    _juzArabic = juzName;
    _isJuz = isJuz;
    _juzId = juzId;
  }

  LastSeen.fromJson(Map<String, dynamic> json) {
    _surahNameArabic = json['surahNameArabic'];
    _surahName = json['surahName'];
    _surahEnglish = json['surahEnglish'];
    _surahId = json['surahId'];
    _ayahId = json['ayahId'];
    _lastSeen = json['lastSeen'];
    _juzArabic = json['juzArabic'];
    _isJuz = json['isJuz'];
    _juzId = json['juzId'];
  }

  Map toJson() {
    return {
      'surahNameArabic': _surahNameArabic,
      'surahName': _surahName,
      "surahEnglish": _surahEnglish,
      "surahId": _surahId,
      "ayahId": _ayahId,
      "lastSeen": _lastSeen,
      "juzArabic": _juzArabic,
      "isJuz": _isJuz,
      "juzId":juzId
    };
  }
}
