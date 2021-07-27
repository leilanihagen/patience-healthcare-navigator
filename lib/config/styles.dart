import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path/path.dart';

class Styles {
  // Original theme:
  static HexColor purpleTheme = HexColor("#66558E");
  static HexColor extraLightPurpleTheme = HexColor("#E7D6FF");
  static HexColor blueTheme = HexColor("#44B5CD"); // 55D0EB 44B5CD
  static HexColor darkPinkTheme = HexColor("#ED558C");
  static HexColor darkGreenTheme = HexColor("#758C20");
  static HexColor lightGreenTheme = HexColor("#A1BF36");

  // "More professional" generated from above:
  static HexColor lighterPurpleTheme = HexColor("#BBB3D0");
  static HexColor lighterBlueTheme = HexColor("#9ED9E6");
  static HexColor darkerBlueTheme = HexColor("#216ED4");
  static HexColor medEmerald = HexColor("#97D8D7");
  static HexColor discordGrey = HexColor("#B9BBBE");
  static HexColor shadowWhite = HexColor("#F4F4F8");
  static HexColor shadowGreen = HexColor("#E7F7FB");
  static HexColor lightCyan = HexColor("#CBEDF6");
  static HexColor middleBlueGreen = HexColor("#85D6EA");
  static HexColor dogYellow = HexColor("#F1D265");

  // Scooter theme:
  static HexColor descriptionExtraLightPurple = HexColor("#DBC2FF");
  static HexColor peachPink = HexColor("#FFD6D6");
  static HexColor nightPurple = HexColor("#928DFF");
  static HexColor lightPurple = HexColor("#C7B6FF");
  static HexColor darkPurple = HexColor("#6050EA");
  static HexColor candyPink = HexColor("#F4C9FE");
  static HexColor modestPink = HexColor("#F17B7F");
  static HexColor grey1 = HexColor("#CCCBCD");

  static HexColor turtleGreen = HexColor("#1E96FC");

  static HexColor descriptionLightPurple = HexColor("#B0A6C9");
  static HexColor lightPurpleTheme = HexColor("#CFADFF");
  static HexColor lightPurple2Theme = HexColor("#C399FF");
  static HexColor extraLightPinkTheme = HexColor("#FBDAE5");
  static HexColor lightPinkTheme = HexColor("#F9C8D8");
  static HexColor medPinkTheme = HexColor("#F5A3BE");
  static HexColor peachPinkTheme = HexColor("#FDD4D5");
  static HexColor candyPinkTheme = HexColor("#FCDFF6");
  static HexColor guildelineSituationBlue = HexColor("#1AC8ED");
  static HexColor medGreenTheme = HexColor("#ABC940");
  static HexColor extraLightGreen = HexColor("#DCE9AF");
  static HexColor lightBlueTheme = HexColor("#98D2EB");
  static HexColor medBlue = HexColor("#289BCC");
  static HexColor darkBrown = HexColor("#3B341F");
  static HexColor darkOrange = HexColor("#FF6542");
  static HexColor lightOrange = HexColor("#FF9B85");
  static HexColor offWhite = HexColor("#FAF2F0");
  static HexColor lightEmerald = HexColor("#A6DDDC");
  static HexColor emerald = HexColor("#5CC1BC");

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
  static const articleBodySmall = TextStyle(fontSize: 16, color: Colors.black);

  static final articleBodySmallGreyed =
      TextStyle(fontSize: 16, color: Colors.grey[700]);

  static const subHeading =
      TextStyle(fontSize: 19, fontWeight: FontWeight.w700);
  static const hintExtraSmall = TextStyle(fontSize: 14, color: Colors.black);
  static const bigImpact =
      TextStyle(fontSize: 60, fontWeight: FontWeight.w500, color: Colors.black);

  static const appBar = TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white);
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
