import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path/path.dart';

class Styles {
  static HexColor purpleTheme = HexColor("#66558E");
  static HexColor extraLightPurpleTheme = HexColor("#E7D6FF");
  // static HexColor descriptionExtraLightPurple = HexColor("#DBC2FF");
  static HexColor descriptionLightPurple = HexColor("#B0A6C9");
  static HexColor lightPurpleTheme = HexColor("#CFADFF");
  static HexColor lightPurple2Theme = HexColor("#C399FF");
  static HexColor lightPinkTheme = HexColor("#FDEBF1");
  static HexColor darkPinkTheme = HexColor("#ED558C");
  static HexColor blueTheme = HexColor("#44B5CD");
  static HexColor guildelineSituationBlue = HexColor("#1AC8ED");
  static HexColor darkGreenTheme = HexColor("#758C20");
  static HexColor lightGreenTheme = HexColor("#A1BF36");
  static HexColor medGreenTheme = HexColor("#ABC940");
  static HexColor extraLightGreen = HexColor("#DCE9AF");
  static HexColor lightBlueTheme = HexColor("#98D2EB");
  static HexColor medBlue = HexColor("#289BCC");
  static HexColor darkBrown = HexColor("#3B341F");
  static HexColor darkOrange = HexColor("#FF6542");
  static HexColor lightOrange = HexColor("#FF9B85");
  static HexColor offWhite = HexColor("#FAF2F0");
  static HexColor emerald = HexColor("#4EBCB6");
  static HexColor lightEmerald = HexColor("#A6DDDB");

  static HexColor extraLightPinkTheme = HexColor("#F9C8D8");
  static HexColor medPink = HexColor("#F391B1");

  static const articleHeading1 =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black);
  static const articleSubtitleLight =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black);
  static const articleHeading1White =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white);
  static final articleHeading1OffWhite =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: offWhite);
  static const buttonTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  );

  static const articleBody = TextStyle(fontSize: 17, color: Colors.black);
  static final articleBodyOffWhite = TextStyle(fontSize: 17, color: offWhite);
  static const articleBodyBold =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.black);
  static const articleBodySmall = TextStyle(fontSize: 16);

  static const subHeading =
      TextStyle(fontSize: 19, fontWeight: FontWeight.w700);
  static const hintExtraSmall = TextStyle(fontSize: 14, color: Colors.black);
  static const bigImpact =
      TextStyle(fontSize: 60, fontWeight: FontWeight.w500, color: Colors.black);

  static const appBar = TextStyle(fontSize: 22, fontWeight: FontWeight.w800);
  static const guidelineCard =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white);
  static const hyperlink = TextStyle(
      fontSize: 17, color: Colors.blue, decoration: TextDecoration.underline);
  static const headerGuildline =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w700);
  static const instruction =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black);

  static const medButton =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.black);
  static const medButtonGrey =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.grey);
  static const smallButtonWhite =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white);
  static const medButtonWhite =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white);
  static const medButtonBlue =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.blue);
  static const largeButtonWhite =
      TextStyle(fontSize: 23, fontWeight: FontWeight.w700, color: Colors.white);

  static const italicMedButton = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w700,
      color: Colors.black,
      fontStyle: FontStyle.italic);

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
