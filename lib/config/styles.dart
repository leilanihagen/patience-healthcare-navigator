import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

class Styles {
  static HexColor purpleTheme = HexColor("#66558E");
  static HexColor extraLightPurpleTheme = HexColor("#E7D6FF");
  static HexColor lightPurpleTheme = HexColor("#CFADFF");
  static HexColor lightPurple2Theme = HexColor("#C399FF");
  static HexColor lightPinkTheme = HexColor("#FDEBF1");
  static HexColor darkPinkTheme = HexColor("#ED558C");
  static HexColor blueTheme = HexColor("#44B5CD");
  static HexColor lightGreenTheme = HexColor("#A1BF36");
  static HexColor darkGreenTheme = HexColor("#758C20");
  static HexColor lightBlueTheme = HexColor("#98D2EB");
  static HexColor darkBrown = HexColor("#3B341F");
  static HexColor extraLightGreen = HexColor("#DCE9AF");
  static HexColor darkOrange = HexColor("#FF6542");

  static const articleHeading1 =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black);
  static const articleHeading1White =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white);
  static const buttonTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  );

  static const articleBody = TextStyle(fontSize: 17, color: Colors.black);
  static const articleBodyBold =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.black);
  static const articleBodySmall = TextStyle(fontSize: 16);
  static const subHeading =
      TextStyle(fontSize: 19, fontWeight: FontWeight.w700);
  static const hintExtraSmall = TextStyle(fontSize: 14, color: Colors.black);
  static const appBar = TextStyle(fontSize: 22, fontWeight: FontWeight.w800);
  static const guidelineCard =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white);
  static const hyperlink = TextStyle(
      fontSize: 17, color: Colors.blue, decoration: TextDecoration.underline);
  static const headerGuildline =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w700);
  static const instruction =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black);
  static const smallButtonWhite =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white);
  static const medButtonWhite =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white);
  static const largeButtonWhite =
      TextStyle(fontSize: 23, fontWeight: FontWeight.w700, color: Colors.white);
  static const backButton = Text(
    "Back",
    style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
  );
  static const dropdownPadding = EdgeInsets.fromLTRB(20, 8, 20, 8);
  static const statusButton =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w700);
  static const EURstyle =
      TextStyle(fontWeight: FontWeight.w600, color: Colors.white);
}
