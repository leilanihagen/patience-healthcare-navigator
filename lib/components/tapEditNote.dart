import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hospital_stay_helper/main.dart';

// DEPRECATED

class TapEditNote extends StatefulWidget {
  @override
  _TapEditNoteState createState() => _TapEditNoteState();
}

class _TapEditNoteState extends State<TapEditNote> {
  String title = '';
  String body = '';

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        padding: const EdgeInsets.all(20.0),
        height: 200, // TODO: make dynamic
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          // Title and note body will be contained within this:

          children: [
            Row(
              children: [
                // Note title:
                GestureDetector(
                    // onTap:
                    child: Expanded(
                        // TODO: Replace placeholder:
                        child: RichText(
                            text: TextSpan(
                                text: 'Untitled',
                                style:
                                    Theme.of(context).textTheme.headline6)))),

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
        ));
  }
}
