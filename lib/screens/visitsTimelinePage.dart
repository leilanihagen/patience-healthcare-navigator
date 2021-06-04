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
        body: Column(
          children: [
            // Add media buttons:
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.camera_alt),
                    color: Colors.white,
                    onPressed: () => {}),
                IconButton(
                    icon: Icon(Icons.mic),
                    color: Colors.white,
                    onPressed: () => {})
              ],
            ),

            // Single note (EXAMPLE):
            Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                padding: const EdgeInsets.all(20.0),
                height: 200, // TODO: make dynamic
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  // Title and note body will be contained within this:

                  children: [
                    // Title line:
                    Row(
                      children: [
                        // Note title:
                        Expanded(
                            // TODO: Replace placeholder:
                            child: RichText(
                                text: TextSpan(
                                    text: 'Untitled',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6))),

                        // Note date/time:
                        Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
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
                )),
          ],
        ));
  }
}
