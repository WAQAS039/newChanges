import 'dart:async';
import 'dart:io';

import 'package:adhan/adhan.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:nour_al_quran/pages/more/pages/salah_timer/salah.dart';
import 'package:nour_al_quran/pages/settings/pages/notifications/notification_services.dart';
import 'package:nour_al_quran/shared/localization/localization_provider.dart';
import 'package:nour_al_quran/shared/network/network_check.dart';
import 'package:nour_al_quran/shared/utills/app_constants.dart';
import 'package:nour_al_quran/shared/widgets/easy_loading.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

class PrayerTimeProvider extends ChangeNotifier {
  final List<Salah> _prayerTimesList = [];
  List<Salah> get prayerTimesList => _prayerTimesList;
  String _sunRise = "5:13";
  String _sunSet = "6:18";
  String get sunRise => _sunRise;
  String get sunSet => _sunSet;
  String _address = "";
  String get address => _address;
  String image = "";
  String tempInC = "";
  bool isPermissionEnable = false;
  int _selectedThem = Hive.box(appBoxKey).get(salahSelectedThem) ?? 1;
  int get selectedThem => _selectedThem;
  final List<bool> _notificationState =
      Hive.box(appBoxKey).get(salahTimerListKey) ??
          [false, false, false, false, false];
  int upcomingPrayerIndex = 0;

  void changeThem(int value) {
    _selectedThem = value;
    notifyListeners();
    Hive.box(appBoxKey).put(salahSelectedThem, value);
  }

  void checkLocationPermission(BuildContext context) async {
    if (await Permission.location.request().isGranted) {
      getSalahPageData(context);
    } else {
      await Permission.location.request().then((value) {
        if (value.isGranted) {
          getSalahPageData(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please Enable Location Services')));
        }
      });
    }
    // bool isLocationServicesEnable = await Permission.location.serviceStatus.isEnabled;
    // bool isGeoEnable = await Geolocator.isLocationServiceEnabled();
    // if(isLocationServicesEnable && isGeoEnable){
    //   Future.delayed(Duration.zero,(){
    //     getSalahPageData(context);
    //   });
    // }else{
    //   await Permission.location.request().then((value) {
    //     if(value.isDenied){
    //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Enable Location Services')));
    //     }else if(value.isGranted){
    //       getSalahPageData(context);
    //     }
    //   });
    // }
  }

  Future<void> getSalahPageData(BuildContext context) async {
    Future.delayed(Duration.zero,
        () => EasyLoadingDialog.show(context: context, radius: 20.r));
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      ).timeout(const Duration(seconds: 10));
      List<Placemark?> placeMarks = await placemarkFromCoordinates(
          position.latitude, position.longitude,
          localeIdentifier: "en");
      if (placeMarks.isNotEmpty) {
        Placemark placeMark = placeMarks[0]!;
        String fullAddress = "${placeMark.locality}, ${placeMark.country}";
        _address = fullAddress;
        NetworksCheck(onComplete: () {
          Future.delayed(
              Duration.zero, () => checkWeather(placeMark.locality!, context));
        }, onError: () {
          EasyLoadingDialog.dismiss(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('No Internet')));
        }).doRequest();
      } else {
        Future.delayed(Duration.zero, () => EasyLoadingDialog.dismiss(context));
      }
      getPrayerTime(lat: position.latitude, lang: position.longitude);
      notifyListeners();
    } on PlatformException catch (e) {
      EasyLoadingDialog.dismiss(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    } on TimeoutException {
      EasyLoadingDialog.dismiss(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('please restart your location services or check network')));
    } catch (e) {
      print(e);
      if (e.toString() ==
          "User denied permissions to access the device's location.") {
        openAppSettingsPermissionSection();
      }
      EasyLoadingDialog.dismiss(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Please Go to Settings and allow application to use Your Location')));
    }
  }

  void setPrayerNotification(
    int index,
  ) {
    _prayerTimesList[index].setIsNotify = !_prayerTimesList[index].notify!;
    _notificationState[index] = !_notificationState[index];
    notifyListeners();
    Hive.box(appBoxKey).put(salahTimerListKey, _notificationState);
    if (_prayerTimesList[index].notify!) {
      // NotificationServices().scheduleNotification(
      //     id: prayerNotificationId+index,
      //     title: _prayerTimesList[index].name!,
      //     body: "${_prayerTimesList[index].name!} prayer time", payload: "home", scheduledDateTime: _prayerTimesList[index].prayerTime!);
    }
  }

  Future<void> openAppSettingsPermissionSection() async {
    if (Platform.isAndroid) {
      const intent = AndroidIntent(
        action: 'action_application_details_settings',
        data: 'package:com.nouralquran.nouralquran',
      );
      await intent.launch();
    }
  }

  void getPrayerTime({required double lat, required double lang}) async {
    final myCoordinates = Coordinates(lat, lang);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);
    _sunRise = DateFormat.jm().format(prayerTimes.sunrise!).toString();
    _sunSet = DateFormat.jm().format(prayerTimes.maghrib!);
    _prayerTimesList.clear();
    _prayerTimesList.add(Salah(
        name: "Fajar",
        time: DateFormat.jm().format(prayerTimes.fajr!).toString(),
        notify: _notificationState[0],
        prayerTime: prayerTimes.fajr!));
    _prayerTimesList.add(Salah(
        name: "dhuhar",
        time: DateFormat.jm().format(prayerTimes.dhuhr!).toString(),
        notify: _notificationState[1],
        prayerTime: prayerTimes.dhuhr!));
    _prayerTimesList.add(Salah(
        name: "Asr",
        time: DateFormat.jm().format(prayerTimes.asr!).toString(),
        notify: _notificationState[2],
        prayerTime: prayerTimes.asr!));
    _prayerTimesList.add(Salah(
        name: "Maghrib",
        time: DateFormat.jm().format(prayerTimes.maghrib!).toString(),
        notify: _notificationState[3],
        prayerTime: prayerTimes.maghrib!));
    _prayerTimesList.add(Salah(
        name: "Isha",
        time: DateFormat.jm().format(prayerTimes.isha!).toString(),
        notify: _notificationState[4],
        prayerTime: prayerTimes.isha!));
    for (int i = 0; i < _prayerTimesList.length; i++) {
      if (_prayerTimesList[i].prayerTime!.isAfter(DateTime.now())) {
        upcomingPrayerIndex = i;
        break;
      }
    }
  }

  void checkWeather(String city, BuildContext context) async {
    try {
      var dio = Dio();
      Response response = await dio.get(
          "http://api.weatherapi.com/v1/current.json?key=73ec04d970d540f1ba3173621232602&q=$city&aqi=yes");
      var data = response.data;
      if (response.statusCode == 200) {
        if (data['current']['condition']['text']
            .toString()
            .toLowerCase()
            .contains("rain")) {
          image = 'assets/images/salah_timer/cloud_drizzle.png';
        } else if (data['current']['condition']['text']
            .toString()
            .toLowerCase()
            .contains("cloudy")) {
          image = 'assets/images/salah_timer/cloud.png';
        } else if (data['current']['condition']['text']
            .toString()
            .toLowerCase()
            .contains("mist")) {
          image = 'assets/images/salah_timer/cloud.png';
        } else if (data['current']['condition']['text']
            .toString()
            .toLowerCase()
            .contains("thunder")) {
          image = 'assets/images/salah_timer/cloud_lightning.png';
        } else if (data['current']['condition']['text']
            .toString()
            .toLowerCase()
            .contains("snow")) {
          image = 'assets/images/salah_timer/cloud_snow.png';
        } else {
          image = 'assets/images/salah_timer/cloud.png';
        }
        tempInC = data['current']['temp_c'].toInt().toString();
        notifyListeners();
        Future.delayed(Duration.zero, () => EasyLoadingDialog.dismiss(context));
      }
    } on DioError {
      EasyLoadingDialog.dismiss(context);
    }
  }
}
