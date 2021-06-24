import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

class Styles {
  static HexColor purpleTheme = HexColor("#66558E");
  static HexColor lightPinkTheme = HexColor("#FDEBF1");
  static const String darkPinkTheme = "#ED558C";
  static HexColor blueTheme = HexColor("#44B5CD");
  // static const String darkGreenTheme = "#758C20";
  static HexColor lightGreenTheme = HexColor("#A1BF36");

  static const articleHeading1 =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black);
  static const articleHeading1White =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white);
  static const buttonTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  );

  static const articleBody = TextStyle(fontSize: 17);
}
