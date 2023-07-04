import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../pages/settings/pages/profile/user_profile.dart';

class UserProfileAdopter extends TypeAdapter<UserProfile>{

  @override
  int get typeId => 4;

  @override
  UserProfile read(BinaryReader reader) {
    String email = reader.read();
    String password = reader.read();
    String fullName = reader.read();
    String image = reader.read();
    String uid = reader.read();
    List<String> quranAppPurpose = reader.read();
    String favReciter = reader.read();
    List<int> bookmarks = reader.read();
    String preferredLanguage = reader.read();
    List loginDevices = reader.read();
    String loginType = reader.read();


    // String whenToReciterQuran = reader.read();
    // DateTime recitationReminder = reader.read();
    // String dailyQuranReadTime = reader.read();

    return UserProfile(
        email: email,
        password: password,
        fullName: fullName,
        image: image,
        uid: uid,
        purposeOfQuran: quranAppPurpose,
        favReciter: favReciter,
        bookmarks: bookmarks,
        preferredLanguage: preferredLanguage,
        loginDevices: loginDevices.map((e) => e as Devices).toList(),
        loginType: loginType

      // whenToReciterQuran: whenToReciterQuran,
      // recitationReminder: recitationReminder,
      // dailyQuranReadTime: dailyQuranReadTime,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer.write(obj.email);
    writer.write(obj.password);
    writer.write(obj.fullName);
    writer.write(obj.image);
    writer.write(obj.uid);
    writer.write(obj.purposeOfQuran);
    writer.write(obj.favReciter);
    writer.write(obj.bookmarks);
    writer.write(obj.preferredLanguage);
    writer.write(obj.loginDevices);
    writer.write(obj.loginType);


    // writer.write(obj.whenToReciterQuran);
    // writer.write(obj.recitationReminder);
    // writer.write(obj.dailyQuranReadTime);
  }

}