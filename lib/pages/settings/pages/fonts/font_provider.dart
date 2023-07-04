import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nour_al_quran/shared/utills/app_constants.dart';

class FontProvider extends ChangeNotifier {
  int _fontSizeArabic = Hive.box(appBoxKey).get(quranFontSizeKey) ?? 20;
  int _fontSizeTranslation = Hive.box(appBoxKey).get(translationFontKey) ?? 15;
  bool _isQuranText = Hive.box(appBoxKey).get(isQuranShowKey) ?? true;
  bool _isTranslationText =
      Hive.box(appBoxKey).get(isTranslationShowKey) ?? true;
  String _finalFont =
      Hive.box(appBoxKey).get(quranFontKey) ?? 'Al Majeed Quranic Font';
  String get finalFont => _finalFont;

  int get fontSizeArabic => _fontSizeArabic;
  int get fontSizeTranslation => _fontSizeTranslation;
  bool get isTranslationText => _isTranslationText;
  bool get isQuranText => _isQuranText;
  final List<String> _fonts = [
    'Al Majeed Quranic Font',
    'PDMS Saleem Quran Font',
    "Scheherazade Font"
  ];
  List<String> get fonts => _fonts;
  String _currentFont = 'Al Majeed Quranic Font';
  String get currentFont => _currentFont;
  double _fontSizeAr = 20;
  double _fontSizeTrans = 15;
  bool _isQuranShow = true;
  bool _isTranShow = true;
  double get fontSizeAr => _fontSizeAr;
  double get fontSizeTrans => _fontSizeTrans;
  bool get isTranShow => _isTranShow;
  bool get isQuranShow => _isQuranShow;

  void init() {
    _fontSizeAr = _fontSizeArabic.toDouble();
    _fontSizeTrans = _fontSizeTranslation.toDouble();
    _isQuranShow = _isQuranText;
    _isTranShow = _isTranslationText;
    _currentFont = _finalFont;
    notifyListeners();
  }

  void setFontSizeArabic(double fontSize) {
    _fontSizeAr = fontSize;
    notifyListeners();
  }

  void setFontSizeTranslation(double fontSize) {
    _fontSizeTrans = fontSize;
    notifyListeners();
  }

  void setIsQuranText(bool value) {
    if (!_isTranShow) {
      _isTranShow = true;
    }
    _isQuranShow = value;
    notifyListeners();
  }

  void setIsTranslationText(bool value) {
    if (!_isQuranShow) {
      _isQuranShow = true;
    }
    _isTranShow = value;
    notifyListeners();
  }

  void setQuranSettings(
      int fontArabic, int fontTrans, bool isShowQuran, bool isShowTrans) {
    _fontSizeArabic = fontArabic;
    _fontSizeTranslation = fontTrans;
    _isQuranText = isShowQuran;
    _isTranslationText = isShowTrans;
    notifyListeners();
    var box = Hive.box(appBoxKey);
    box.put(quranFontSizeKey, _fontSizeArabic);
    box.put(translationFontKey, _fontSizeTranslation);
    box.put(isQuranShowKey, _isQuranText);
    box.put(isTranslationShowKey, _isTranslationText);
  }

  void setFontSettings() {
    _fontSizeArabic = _fontSizeAr.toInt();
    _fontSizeTranslation = _fontSizeTrans.toInt();
    _finalFont = _currentFont;
    notifyListeners();
    var box = Hive.box(appBoxKey);
    box.put(quranFontSizeKey, _fontSizeArabic);
    box.put(translationFontKey, _fontSizeTranslation);
    box.put(quranFontKey, _finalFont);
  }

  void setCurrentFont(String font) {
    _currentFont = font;
    notifyListeners();
  }
}
