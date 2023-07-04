import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:nour_al_quran/pages/settings/pages/translation_manager/translations.dart';
import 'package:nour_al_quran/shared/utills/app_constants.dart';

class QuranText {
  int? _surahId;
  int? _verseId;
  int? _juzId;
  String? _verseText;
  String? _translationText;
  int? _isBookmark;
  int? get juzId => _juzId;

  int? get surahId => _surahId;
  int? get verseId => _verseId;

  String? get verseText => _verseText;
  String? get translationText => _translationText;
  int? get isBookmark => _isBookmark;

  set setIsBookmark(int value) => _isBookmark = value;

  set setTranslationText(String value) => _translationText = value;

  QuranText(
      {required surahId,
      required verseId,
      required juzId,
      required verseText,
      required translationText,
      required isBookmark}) {
    _surahId = surahId;
    _verseId = verseId;
    _juzId = juzId;
    _verseText = verseText;
    _translationText = translationText;
    _isBookmark = isBookmark;
  }

  static QuranText fromJson(Map<String, dynamic> json) {
    return QuranText(
        surahId: json['surah_id'],
        verseId: json['verse_id'],
        juzId: json['juz_id'],
        verseText: json['quran_text_uthmani'],
        translationText: json[
            Hive.box(appBoxKey).get(selectedQuranTranslationKey) != null
                ? Translations.fromJson(jsonDecode(
                        Hive.box(appBoxKey).get(selectedQuranTranslationKey)))
                    .translationName
                : "translation_english_hilali"],
        isBookmark: json['is_bookmark']);
  }

  Map<String, dynamic> toJson() {
    return {
      "surah_id": _surahId,
      "verse_id": _verseId,
      "juz_id": _juzId,
      "quran_text_uthmani": _verseText,
      Hive.box(appBoxKey).get(selectedQuranTranslationKey) != null
          ? Translations.fromJson(jsonDecode(
                  Hive.box(appBoxKey).get(selectedQuranTranslationKey)))
              .translationName
              .toString()
          : "translation_english_hilali": _translationText,
      "is_bookmark": _isBookmark
    };
  }

  String getTranslation(String translationName) {
    Map<String, dynamic> json = toJson();
    return json[translationName];
  }
}
