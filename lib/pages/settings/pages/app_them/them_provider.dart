import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class ThemProvider extends ChangeNotifier{
  bool _isDark = Hive.box("myBox").get("isDark") ?? false;
  bool get isDark => _isDark;

  void setToDark(bool dark){
    _isDark = dark;
    Hive.box("myBox").put("isDark", _isDark);
    notifyListeners();
  }
}