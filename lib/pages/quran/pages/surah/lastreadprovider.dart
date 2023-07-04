// quran_provider.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LastReadProvider extends ChangeNotifier {
  List<String> tappedSurahNames = [];

  void setTappedSurahNames(List<String> names) {
    tappedSurahNames = names;
    notifyListeners();
  }

  void addTappedSurahName(String name) {
    tappedSurahNames.add(name);
    notifyListeners();
  }
}

Future<void> loadTappedSurahNames(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? savedNames = prefs.getStringList('tappedSurahNames');

  context.read<LastReadProvider>().setTappedSurahNames(savedNames ?? []);
}

Future<void> saveTappedSurahNames(BuildContext context) async {
  List<String> tappedSurahNames =
      context.read<LastReadProvider>().tappedSurahNames;

  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (tappedSurahNames.length > 10) {
    tappedSurahNames = tappedSurahNames.sublist(tappedSurahNames.length - 10);
  }

  await prefs.setStringList('tappedSurahNames', tappedSurahNames);

  context.read<LastReadProvider>().setTappedSurahNames(tappedSurahNames);
}
