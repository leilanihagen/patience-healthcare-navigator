// import 'package:flutter/material.dart';
// import 'package:hospital_stay_helper/class/sharePref.dart';
// import 'package:hospital_stay_helper/localizations/localization.dart';

// const String LAGUAGE_CODE = 'languageCode';

// //languages code
// const String ENGLISH = 'en';
// const String SPANISH = 'es';
// const String KOREAN = 'kr';
// const String VIETNAMESE = 'vi';

// Future<Locale> setLocale(String languageCode) async {
//   await MySharedPreferences.instance.setStringValue(LAGUAGE_CODE, languageCode);
//   return _locale(languageCode);
// }

// Future<Locale> getLocale() async {
//   String languageCode =
//       await MySharedPreferences.instance.getStringValue(LAGUAGE_CODE) ?? "en";
//   return _locale(languageCode);
// }

// Locale _locale(String languageCode) {
//   switch (languageCode) {
//     case ENGLISH:
//       return Locale(ENGLISH, 'US');
//     case SPANISH:
//       return Locale(SPANISH, "ES");
//     case KOREAN:
//       return Locale(KOREAN, "KR");
//     case VIETNAMESE:
//       return Locale(VIETNAMESE, "IN");
//     default:
//       return Locale(ENGLISH, 'US');
//   }
// }

// String? getTranslated(BuildContext context, String key) {
//   return Localization.of(context)!.translate(key);
// }
