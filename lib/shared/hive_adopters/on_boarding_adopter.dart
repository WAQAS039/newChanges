import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nour_al_quran/pages/onboarding/models/on_boarding_information.dart';

class OnBoardingAdopter extends TypeAdapter<OnBoardingInformation>{
  @override
  int get typeId => 5;

  @override
  OnBoardingInformation read(BinaryReader reader) {
    List<String> purposeOfQuran = reader.read();
    String favReciter = reader.read();
    Locale preferredLanguage = reader.read();

    // String whenToReciterQuran = reader.read();
    // TimeOfDay recitationReminder = reader.read();
    // String dailyQuranReadTime = reader.read();


    return OnBoardingInformation(
        purposeOfQuran: purposeOfQuran,
        favReciter: favReciter,
        preferredLanguage: preferredLanguage

      // whenToReciterQuran: whenToReciterQuran,
      // recitationReminder: recitationReminder,
      // dailyQuranReadTime: dailyQuranReadTime,

    );


  }

  @override
  void write(BinaryWriter writer, OnBoardingInformation obj) {
    writer.write(obj.purposeOfQuran);
    writer.write(obj.favReciter);
    writer.write(obj.preferredLanguage);


    // writer.write(obj.whenToReciterQuran);
    // writer.write(obj.recitationReminder);
    // writer.write(obj.dailyQuranReadTime);
  }

}