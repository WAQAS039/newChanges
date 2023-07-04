import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nour_al_quran/pages/more/pages/names_of_allah/names.dart';

class NamesProvider extends ChangeNotifier {
  List<Names> _names = [];
  List<Names> get names => _names;

  Future<void> getNames(BuildContext context) async {
    _names = [];
    var assetsBundle = DefaultAssetBundle.of(context);
    var data = await assetsBundle.loadString('assets/data/names_of_allah.json');
    var jsonData = json.decode(data);
    var namesList = jsonData['names_of_Allah'];
    for (var name in namesList) {
      Names model = Names.fromJson(name);
      _names.add(model);
    }
    notifyListeners();
    print(_names.length);
  }
}
