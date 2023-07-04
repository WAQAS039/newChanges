import 'package:flutter/cupertino.dart';
import 'localization_demo.dart';

String localeText(BuildContext context, String key) {
  final localizationDemo = LocalizationDemo.of(context);
  return localizationDemo?.getTranslatedValue(key) ?? '';
}

const supportedLocales = [
  Locale('en', "US"), // English
  Locale('ur', "PK"), // URDU
  Locale('hi', "IN"), // HINDI
  Locale('ar', "SA"), // ARABIC
  Locale('bn', "BD"), // BENGALI
  Locale('de', "DE"), // GERMAN
  Locale('zh', "CN"), // CHINESE
  Locale('es', "AG"), // Spanish
  Locale('fr', "BE"), // french
  Locale('id', "IN"), // Indonesia
];

Locale? localeResolutionCallback(deviceLocale, supportedLocale) {
  for (var local in supportedLocale) {
    if (local.languageCode == deviceLocale!.languageCode &&
        local.countryCode == deviceLocale.countryCode) {
      return deviceLocale;
    }
  }
  return supportedLocale.first;
}
