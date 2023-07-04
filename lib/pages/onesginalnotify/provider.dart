import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalProvider extends ChangeNotifier {
  final String _onesignalAppId = "cdb0213c-900e-49fc-83b8-b5771db4a960";

  void initializeOneSignal() {
    //OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId(_onesignalAppId);
    OneSignal.shared.setNotificationOpenedHandler((openedResult) {
      // Handle notification opening logic
    });

    /* OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId("2c5504d6-be2d-4437-a602-ac28a5c06cbe");

    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted){
      print("Accepted Permission: $accepted");
    });
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print('NOTIFICATION OPENED HANDLER CALLED WITH: ${result}');
    });

    OneSignal.shared
        .setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
      print('FOREGROUND HANDLER CALLED WITH: ${event}');
      /// Display Notification, send null to not display
      event.complete(null);
    });*/
  }
}
