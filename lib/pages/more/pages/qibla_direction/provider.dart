import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nour_al_quran/shared/widgets/easy_loading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/routes/routes_helper.dart';

class QiblaProvider extends ChangeNotifier {
  String _address = "";
  String get address => _address;
  double _lat = 0.0;
  double get lat => _lat;
  double _lng = 0.0;
  double get lng => _lng;
  int _qiblaDistance = 0;
  int get qiblaDistance => _qiblaDistance;

  Future getLocationPermission(BuildContext context) async {
    if (await Permission.location.request().isDenied) {
      Future.delayed(Duration.zero, () => getQiblaPageData(context));
    } else {
      await Permission.location.request().then((value) {
        if (value.isGranted) {
          Future.delayed(Duration.zero, () => getQiblaPageData(context));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please Enable Location Services')));
        }
      });
    }
  }

  Future<void> getLocationPermissionIOS(BuildContext context) async {
    final status = await Permission.locationWhenInUse.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Enable Location Services'),
            content: const Text(
                'Location services are required for this app. Please enable location services in the device settings.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Open Settings'),
                onPressed: () {
                  openDeviceSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> openDeviceSettings() async {
    final appSettings = Uri.parse('app-settings:');
    if (await canLaunch(appSettings.toString())) {
      await launch(appSettings.toString());
    } else {
      print('Could not open the app settings.');
    }
  }

  Future<void> getQiblaPageData(BuildContext context) async {
    EasyLoadingDialog.show(context: context, radius: 20.r);
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      ).timeout(const Duration(seconds: 5));
      _lat = position.latitude;
      _lng = position.longitude;
      _qiblaDistance = calculateQiblaDistance(_lat, _lng).toInt();
      List<Placemark?> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placeMarks.isNotEmpty) {
        Placemark placeMark = placeMarks[0]!;
        String fullAddress = "${placeMark.locality}, ${placeMark.country}";
        _address = fullAddress;
        notifyListeners();
      }
      Future.delayed(Duration.zero, () {
        EasyLoadingDialog.dismiss(context);
        Navigator.of(context).pushNamed(
          RouteHelper.qiblaDirection,
        );
      });
    } on PlatformException catch (e) {
      EasyLoadingDialog.dismiss(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    } on TimeoutException catch (e) {
      EasyLoadingDialog.dismiss(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('please restart your location services or check network')));
    } catch (e) {
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

  Future<void> openAppSettingsPermissionSection() async {
    if (Platform.isAndroid) {
      const intent = AndroidIntent(
        action: 'action_application_details_settings',
        data: 'package:com.nouralquran.nouralquran',
      );
      await intent.launch();
    } else if (Platform.isIOS) {
      const String settingsUrl = 'app-settings:';
      if (await canLaunchUrl(settingsUrl as Uri)) {
        await launchUrl(settingsUrl as Uri);
      } else {
        throw 'Could not launch the app settings page.';
      }
    }
  }

  double calculateQiblaDistance(double latitude, double longitude) {
    // Coordinates of the Kaaba in Mecca
    const double kaabaLatitude = 21.4225;
    const double kaabaLongitude = 39.8262;

    // Convert latitude and longitude to radians
    double lat1 = latitude * pi / 180.0;
    double lon1 = longitude * pi / 180.0;
    double lat2 = kaabaLatitude * pi / 180.0;
    double lon2 = kaabaLongitude * pi / 180.0;

    // Calculate the difference between the longitudes
    double dLon = lon2 - lon1;

    // Calculate the qibla direction (in radians)
    double qiblaDirection =
        atan2(sin(dLon), cos(lat1) * tan(lat2) - sin(lat1) * cos(dLon));

    // Convert qibla direction to degrees
    qiblaDirection = qiblaDirection * 180.0 / pi;

    // Calculate the distance to the qibla (in kilometers)
    double earthRadius = 6371.0; // Radius of the Earth in kilometers
    double distance =
        acos(sin(lat1) * sin(lat2) + cos(lat1) * cos(lat2) * cos(dLon)) *
            earthRadius;

    return distance;
  }
}
