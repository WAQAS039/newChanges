import 'package:flutter/cupertino.dart';

class UserProfile{
  String? _email;
  String? _password;
  String? _fullName;
  String? _image;
  String? _uid;
  List<String>? _purposeOfQuran;
  String? _favReciter;
  List<int>? _bookmarks;
  String? _preferredLanguage;
  List<Devices>? _loginDevices;
  String? _loginType;



  String? get email => _email;
  String? get password => _password;
  String? get fullName => _fullName;
  String? get image => _image;
  String? get uid => _uid;
  List<String>? get purposeOfQuran => _purposeOfQuran;
  String? get favReciter => _favReciter;
  List<int>? get bookmarks => _bookmarks;
  String? get preferredLanguage => _preferredLanguage;
  String? get loginType => _loginType;
  List<Devices>? get loginDevices => _loginDevices;

  // String? _whenToReciterQuran;
  // DateTime? _recitationReminder;
  // String? _dailyQuranReadTime;


  // String? get whenToReciterQuran => _whenToReciterQuran;
  // DateTime? get recitationReminder => _recitationReminder;
  // String? get dailyQuranReadTime => _dailyQuranReadTime;



  set setPreferredLanguage(String value) =>_preferredLanguage = value;


  set setFullName(String value) => _fullName = value;


  set setEmail(String value) =>_email = value;
  set setPassword(String value) => _password = value;

  UserProfile({
    required email,
    required password,
    required fullName,
    required image,
    required uid,
    required purposeOfQuran,
    required favReciter,
    required bookmarks,
    required preferredLanguage,
    required loginDevices,
    required loginType
    // required whenToReciterQuran,
    // required recitationReminder,
    // required dailyQuranReadTime,
  }){
    _email = email;
    _password = password;
    _fullName = fullName;
    _image = image;
    _uid = uid;
    _purposeOfQuran = purposeOfQuran;
    _favReciter = favReciter;
    _bookmarks = bookmarks;
    _preferredLanguage = preferredLanguage;
    _loginDevices = loginDevices;
    _loginType = loginType;

    // _whenToReciterQuran = whenToReciterQuran;
    // _recitationReminder = recitationReminder;
    // _dailyQuranReadTime = dailyQuranReadTime;
  }

  UserProfile.fromJson(Map<String,dynamic> json){
    _email = json['email'];
    _password = json['password'];
    _fullName = json['fullName'];
    _image = json['image'];
    _uid = json['uid'];
    _purposeOfQuran = List<String>.from(json['purposeOfQuran']);
    _favReciter = json['favReciter'];
    _bookmarks = List<int>.from(json['bookmarks']);
    _preferredLanguage = json['preferredLanguage'];
    if(json['loginDevices'] != null){
      _loginDevices = [];
      for(var map in json['loginDevices']){
        _loginDevices!.add(Devices.fromJson(map));
      }
    }
    _loginType = json['loginType'];

    // _whenToReciterQuran = json['whenToReciterQuran'];
    // _recitationReminder = json['recitationReminder'].toDate();
    // _dailyQuranReadTime = json['dailyQuranReadTime'];
  }

  Map<String,dynamic> toJson(){
    return {
      'email' : _email,
      'password' : _password,
      'fullName' : _fullName,
      'image' : _image,
      'uid' : _uid,
      'purposeOfQuran': _purposeOfQuran,
      'favReciter' : _favReciter,
      'bookmarks':_bookmarks,
      'preferredLanguage' : _preferredLanguage,
      'loginDevices' : _loginDevices!.map((e) => e.toJson()).toList(),
      "loginType":_loginType


      // 'whenToReciterQuran' : _whenToReciterQuran,
      // 'recitationReminder' : _recitationReminder,
      // 'dailyQuranReadTime' : _dailyQuranReadTime,
    };
  }
}


class Devices {
  String? _name;
  DateTime? _datetime;

  String? get name => _name;
  DateTime? get datetime => _datetime;

  Devices({name, datetime}){
    _name = name;
    _datetime = datetime;
  }

  Devices.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _datetime = json['datetime'].toDate();
  }

  Map<String, dynamic> toJson() {
    return {
      "name":_name,
      "datetime":_datetime
    };
  }


}