class Surah {
  int? _surahId;
  String? _surahName;
  String? _englishName;
  String? _arabicName;

  int? get surahId => _surahId;
  String? get surahName => _surahName;
  String? get englishName => _englishName;
  String? get arabicName => _arabicName;

  Surah(
      {required surahId,
      required surahName,
      required englishName,
      required arabicName}) {
    _surahId = surahId;
    _surahName = surahName;
    _englishName = englishName;
    _arabicName = arabicName;
  }

  static Surah fromJson(Map<String, dynamic> map) {
    return Surah(
        surahId: map['Id'],
        surahName: map['surah_name'],
        englishName: map['english_name'],
        arabicName: map['arabic_name']);
  }
}
