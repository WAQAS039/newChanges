import 'package:flutter/material.dart';

class OnBoardingInformation{
  List<String>? _purposeOfQuran;
  String? _favReciter;
  Locale? _preferredLanguage;

  // String? _whenToReciterQuran;
  // TimeOfDay? _recitationReminder;
  // String? _dailyQuranReadTime;

  /// getters
  List<String>? get purposeOfQuran => _purposeOfQuran;
  String? get favReciter => _favReciter;
  Locale? get preferredLanguage => _preferredLanguage;
  // String? get whenToReciterQuran => _whenToReciterQuran;
  // TimeOfDay? get recitationReminder => _recitationReminder;
  // String? get dailyQuranReadTime => _dailyQuranReadTime;


  OnBoardingInformation({
    required purposeOfQuran,
    required favReciter,
    required preferredLanguage,
    // required whenToReciterQuran,
    // required recitationReminder,
    // required dailyQuranReadTime,
    }){
    _purposeOfQuran = purposeOfQuran;
    _favReciter = favReciter;
    _preferredLanguage = preferredLanguage;
    // _whenToReciterQuran = whenToReciterQuran;
    // _recitationReminder = recitationReminder;
    // _dailyQuranReadTime = dailyQuranReadTime;
  }

  OnBoardingInformation.fromJson(Map<String,dynamic> json){
    _purposeOfQuran = json['purposeOfQuran'];
    _favReciter = json['favReciter'];
    _preferredLanguage = json['preferredLanguage'];
    // _whenToReciterQuran = json['whenToReciterQuran'];
    // _recitationReminder = json['recitationReminder'];
    // _dailyQuranReadTime = json['dailyQuranReadTime'];
  }

  Map toJson(){
    return {
      'purposeOfQuran': _purposeOfQuran,
      'favReciter' : _favReciter,
      'preferredLanguage' : _preferredLanguage,
      // 'whenToReciterQuran' : _whenToReciterQuran,
      // 'recitationReminder' : _recitationReminder,
      // 'dailyQuranReadTime' : _dailyQuranReadTime,
    };
  }
}