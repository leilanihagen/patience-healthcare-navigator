import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Localization {
  Localization(this.locale);

  final Locale locale;
  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  Map<String, String> _mainValues;

  Future<void> load() async {
    String jsonStringValues = await rootBundle
        .loadString('locales/${locale.languageCode.toUpperCase()}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _mainValues = Map<String, String>.from(mappedJson['main']);
  }

  String translate(String key) {
    return _mainValues[key];
  }

  // static member to have simple access to the delegate from Material App
  static const LocalizationsDelegate<Localization> delegate =
      _DemoLocalizationsDelegate();
}

class _DemoLocalizationsDelegate extends LocalizationsDelegate<Localization> {
  const _DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es', 'kr', 'vi'].contains(locale.languageCode);
  }

  @override
  Future<Localization> load(Locale locale) async {
    Localization localization = new Localization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) => false;
}
