import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Styles {
  // Original theme:
  Styles._();
  static const Color purpleTheme = Color(0xff66558E);
  static const Color extraLightPurpleTheme = Color(0xffE7D6FF);
  static const Color blueTheme = Color(0xff44B5CD); // 55D0EB 44B5CD
  static const Color darkPinkTheme = Color(0xffED558C);
  static const Color darkGreenTheme = Color(0xff758C20);
  static const Color lightGreenTheme = Color(0xffA1BF36);

  // "More professional" generated from above:
  static const Color lighterPurpleTheme = Color(0xffBBB3D0);
  static const Color lighterBlueTheme = Color(0xff9ED9E6);
  static const Color darkerBlueTheme = Color(0xff216ED4);
  static const Color medEmerald = Color(0xff97D8D7);
  static const Color discordGrey = Color(0xffB9BBBE);
  static const Color shadowWhite = Color(0xffF4F4F8);
  static const Color shadowGreen = Color(0xffE7F7FB);
  static const Color lightCyan = Color(0xffCBEDF6);
  static const Color middleBlueGreen = Color(0xff85D6EA);
  static const Color dogYellow = Color(0xffF1D265);

  // Scooter theme:
  static const Color descriptionExtraLightPurple = Color(0xffDBC2FF);
  static const Color peachPink = Color(0xffFFD6D6);
  static const Color nightPurple = Color(0xff928DFF);
  static const Color lightPurple = Color(0xffC7B6FF);
  static const Color darkPurple = Color(0xff6050EA);
  static const Color candyPink = Color(0xffF4C9FE);
  static const Color modestPink = Color(0xffF17B7F);
  static const Color grey1 = Color(0xffCCCBCD);

  static const Color turtleGreen = Color(0x1E96FC);

  static const Color descriptionLightPurple = Color(0xffB0A6C9);
  static const Color lightPurpleTheme = Color(0xffCFADFF);
  static const Color lightPurple2Theme = Color(0xffC399FF);
  static const Color extraLightPinkTheme = Color(0xffFBDAE5);
  static const Color lightPinkTheme = Color(0xffF9C8D8);
  static const Color medPinkTheme = Color(0xffF5A3BE);
  static const Color peachPinkTheme = Color(0xffFDD4D5);
  static const Color candyPinkTheme = Color(0xffFCDFF6);
  static const Color guildelineSituationBlue = Color(0xff1AC8ED);
  static const Color medGreenTheme = Color(0xffABC940);
  static const Color extraLightGreen = Color(0xffDCE9AF);
  static const Color lightBlueTheme = Color(0xff98D2EB);
  static const Color medBlue = Color(0xff289BCC);
  static const Color darkBrown = Color(0xff3B341F);
  static const Color darkOrange = Color(0xffFF6542);
  static const Color lightOrange = Color(0xffFF9B85);
  static const Color offWhite = Color(0xffFAF2F0);
  static const Color lightEmerald = Color(0xffA6DDDC);
  static const Color emerald = Color(0xff5CC1BC);

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

  static const appBar =
      TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white);
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
