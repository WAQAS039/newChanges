// class UserProfile{
//   String? _fullName;
//   String? _email;
//   String? _password;
//   String? _photoUrl;
//   String? _uid;
//   String? _preferredLanguage;
//   List<String>? _quranAppPurpose;
//   String? _favReciter;
//   String? _loginType;
//
//   String? get fullName => _fullName;
//
//   String? get email => _email;
//
//   String? get favReciter => _favReciter;
//
//   List<String>? get quranAppPurpose => _quranAppPurpose;
//
//   String? get preferredLanguage => _preferredLanguage;
//
//   String? get password => _password;
//
//   String? get loginType => _loginType;
//
//   String? get photoUrl => _photoUrl;
//   String? get uid => _uid;
//
//   UserProfile({required fullName, required email, required password,required photoUrl,required uid,
//     required preferredLanguage, required quranAppPurpose, required favReciter,required loginType}){
//     _fullName = fullName;
//     _email = email;
//     _password = password;
//     _photoUrl = photoUrl;
//     _uid = uid;
//     _preferredLanguage = preferredLanguage;
//     _quranAppPurpose = quranAppPurpose;
//     _favReciter = favReciter;
//     _loginType = loginType;
//   }
//
//   UserProfile.fromJson(Map<String,dynamic> json){
//     _fullName = json['fullName'];
//     _email = json['email'];
//     _password = json['password'];
//     _photoUrl = json['photoUrl'];
//     _uid = json["uid"];
//     _preferredLanguage = json['preferredLanguage'];
//     _quranAppPurpose = json['quranAppPurpose'];
//     _favReciter = json['favReciter'];
//     _loginType = json['loginType'];
//   }
// }