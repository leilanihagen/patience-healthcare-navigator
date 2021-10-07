import 'package:flutter/widgets.dart';

class CustomIcon {
  CustomIcon._();

  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData lightbulb =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData psuLogo =
      IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
