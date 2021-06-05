import 'package:expandable/expandable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hospital_stay_helper/main.dart';
import 'package:hospital_stay_helper/screens/visitDetailPage.dart';

class VisitsTimelinePage extends StatelessWidget {
  VisitsTimelinePage({Key key}) : super(key: key); // ?

  final String purpleTheme = "#66558E";
  final String lightPinkTheme = "#FDEBF1";
  final String darkPinkTheme = "#ED558C";
  final String blueTheme = "#44B5CD";
  // final String darkGreenTheme = "#758C20";
  final String lightGreenTheme = "#A1BF36";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor(purpleTheme),
        body: Column(
          // Render each visit:
          children: [
            // Visit (EXAMPLE):
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VisitDetailPage())),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)),
                height: 240,
              ),
            ),
          ],
        ));
  }
}
