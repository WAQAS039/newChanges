import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AppColorsProvider extends ChangeNotifier{
  Color _mainBrandingColor = Color(Hive.box('myBox').get("brandingColor") ?? 0xFF27AE60);
  Color get mainBrandingColor => _mainBrandingColor;
  Color _selectedColor = Color(Hive.box('myBox').get("brandingColor") ?? 0xFF27AE60);
  Color get selectedColor => _selectedColor;

  void setSelectedColor(Color color){
    _selectedColor = color;
    notifyListeners();
  }
  void setMainBrandingColor(Color color,int colorValue){
    _mainBrandingColor = color;
    Hive.box('myBox').put("brandingColor", colorValue);
    notifyListeners();
  }

}