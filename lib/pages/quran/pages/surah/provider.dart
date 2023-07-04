import 'package:flutter/material.dart';
import 'package:nour_al_quran/shared/database/quran_db.dart';
import 'package:nour_al_quran/shared/entities/surah.dart';
import 'package:shared_preferences/shared_preferences.dart';

class recentProvider extends ChangeNotifier {
  List<Surah> _surahNamesList = [];
  List<Surah> get surahNamesList => _surahNamesList;

  Future<void> getSurahName() async {
    _surahNamesList = await QuranDatabase().getSurahName();
    notifyListeners();
  }
}
