import 'package:flutter/material.dart';
import 'package:nour_al_quran/shared/database/quran_db.dart';
import 'package:nour_al_quran/shared/entities/surah.dart';

class SurahProvider extends ChangeNotifier {
  List<Surah> _surahNamesList = [];
  List<Surah> get surahNamesList => _surahNamesList;

  Future<void> getSurahName() async {
    _surahNamesList = await QuranDatabase().getSurahName();
    notifyListeners();
  }

  void searchSurah(String query) async {
    var surahName = await QuranDatabase().getSurahName();
    if (query.isEmpty) {
      _surahNamesList = surahName;
    } else {
      final suggestions = surahName.where((surah) {
        final title = surah.surahName!.toLowerCase();
        final input = query.toLowerCase();
        return title.contains(input);
      }).toList();
      _surahNamesList = suggestions;
    }
    notifyListeners();
  }
}
