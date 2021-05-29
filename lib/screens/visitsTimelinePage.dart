import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hospital_stay_helper/main.dart';

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
        body: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            padding: const EdgeInsets.all(20.0),
            height: 200, // TODO: make dynamic
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              // Title and note body will be contained within this:

              children: [
                Row(
                  // Title line:
                  children: [
                    // Note title:
                    Expanded(
                        // TODO: Replace placeholder:
                        child: Text('Untitled')),

                    // Note date/time:
                    Container(
                        child: Column(
                      children: [
                        // TODO: Replace placeholders:
                        RichText(
                            text: TextSpan(
                          text: '12:26 PM',
                          style: TextStyle(color: Colors.black),
                        )),
                        RichText(
                            text: TextSpan(
                          text: '6 April 2021',
                          style: TextStyle(color: Colors.black),
                        )),
                      ],
                    ))
                  ],
                )
              ],
            )));
  }
}
