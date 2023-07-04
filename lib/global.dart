import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nour_al_quran/pages/settings/pages/my_state/my_state_provider_updated.dart';
import 'package:nour_al_quran/pages/settings/pages/notifications/notification_services.dart';
import 'package:nour_al_quran/shared/database/home_db.dart';
import 'package:nour_al_quran/shared/database/quran_db.dart';
import 'package:nour_al_quran/shared/hive_adopters/bookmark_adopter.dart';
import 'package:nour_al_quran/shared/hive_adopters/devices_adopter.dart';
import 'package:nour_al_quran/shared/hive_adopters/duaboomark_adopter.dart';
import 'package:nour_al_quran/shared/hive_adopters/duration_adapter.dart';
import 'package:nour_al_quran/shared/hive_adopters/last_seen_adopter.dart';
import 'package:nour_al_quran/shared/hive_adopters/locale_adopter.dart';
import 'package:nour_al_quran/shared/hive_adopters/on_boarding_adopter.dart';
import 'package:nour_al_quran/shared/hive_adopters/ruqyahbookmark_adopter.dart';
import 'package:nour_al_quran/shared/hive_adopters/time_of_the_day_adopter.dart';
import 'package:nour_al_quran/shared/hive_adopters/user_profile_adopter.dart';
import 'package:nour_al_quran/shared/localization/localization_provider.dart';
import 'package:path_provider/path_provider.dart';

class Global {
  static init() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      // statusBarColor: Colors.white
    ));
    await Firebase.initializeApp();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    Directory dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);
    Hive.registerAdapter(DurationAdapter());
    Hive.registerAdapter(LastSeenAdapter());
    Hive.registerAdapter(LocaleAdapter());
    Hive.registerAdapter(BookmarksAdapter());
    Hive.registerAdapter(DuaBookmarksAdapter());
    Hive.registerAdapter(RuqyahBookmarksAdapter());
    Hive.registerAdapter(UserProfileAdopter());
    Hive.registerAdapter(OnBoardingAdopter());
    Hive.registerAdapter(TimeOfTheDayAdapter());
    Hive.registerAdapter(DevicesAdapter());

    await Hive.openBox('myBox');
    await ScreenUtil.ensureScreenSize();
    await QuranDatabase().initAndSaveDb();
    await HomeDb().initDb();
    await MyStateProvider().initUserDb();
    await NotificationServices().init();
    HijriCalendar.setLocal(LocalizationProvider().locale.languageCode);
  }
}
