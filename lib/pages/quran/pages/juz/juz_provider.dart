import 'package:flutter/material.dart';
import 'package:nour_al_quran/shared/database/quran_db.dart';
import 'package:nour_al_quran/shared/entities/juz.dart';

class JuzProvider extends ChangeNotifier{
  List<Juz> _juzNamesList = [];
  List<Juz> get juzNameList => _juzNamesList;

  Future<void> getJuzNames() async {
    _juzNamesList = await QuranDatabase().getJuzNames();
    notifyListeners();
  }

  void searchJuz(String query) async{
    // copy of list
    var juzNames = await QuranDatabase().getJuzNames();
    if (query.isEmpty) {
      // actual list
      _juzNamesList = juzNames;
    } else {
      final suggestions = juzNames.where((juz) {
        final title = juz.juzEnglish!.toLowerCase();
        final input = query.toLowerCase();
        return title.contains(input);
      }).toList();
      _juzNamesList = suggestions;
    }
    notifyListeners();
  }
}