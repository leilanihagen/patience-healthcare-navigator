import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hospital_stay_helper/main.dart';
import 'package:hospital_stay_helper/screens/visitDetailPage.dart';
import '../class/sharePref.dart';

class VisitsTimelinePage extends StatefulWidget {
  VisitsTimelinePage({Key key}) : super(key: key);

  @override
  _VisitsTimelinePageState createState() => _VisitsTimelinePageState();
}

class _VisitsTimelinePageState extends State<VisitsTimelinePage> {
  final String purpleTheme = "#66558E";
  final String lightPinkTheme = "#FDEBF1";
  final String darkPinkTheme = "#ED558C";
  final String blueTheme = "#44B5CD";
  // final String darkGreenTheme = "#758C20";
  final String lightGreenTheme = "#A1BF36";

  int visitsCount = 3;
  List<String> visitsDates = ['Today', '03/04/2019', '02/28/2020'];
  List<String> visitsTimes = ['NOW', '3:26 PM', '12:39 PM'];
  List<String> visitsPatients = ['Sally', 'Sally', 'Sally'];
  // List<dynamic> notesTitles = [];

  // TEST: Note data storage + encoding testing:
  List<List<String>> notesTitles = [
    ['Checked in at Legacy', 'Saw Nurse Kathy R.', 'haha'],
    [
      'Taken in ambulance to peacehelth',
      'Arrived at ER',
      'Seen by doctor Cylde R.'
    ],
    ['This hapened'],
  ];
  List<List<String>> notesBodies = [
    ['Detail about this happended', 'more detail then this happened'],
    ['Arrived at x hospital and blah b;ah b', 'Seen by Dr. Strange jdehf[ oei'],
    ['This happened'],
  ];
  List<dynamic> decodedTitles = [
    ['', ''],
    ['', '']
  ];

  void storeTestNoteData() {
    MySharedPreferences.instance
        .setStringValue('test_note_titles', jsonEncode(notesTitles));
  }

  void readTestNoteData() async {
    MySharedPreferences.instance
        .getStringValue('test_note_titles')
        .then((String res) {
      decodedTitles = jsonDecode(res);
    });
  }

  void performStoreReadTest() {
    storeTestNoteData();
    readTestNoteData();
  }

  void updateDate(int visitIndex, String data) {
    // Call when date TapEditBox pressed:
    setState(() {
      visitsDates[visitIndex] = data;
    });
  }

  getVisits() {
    return GestureDetector(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => VisitDetailPage())),
        child: ListView.builder(
            itemCount: visitsCount,
            itemBuilder: (context, index) {
              // Visit:
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    color: HexColor(lightGreenTheme),
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3))
                    ]),
                height: 310,
                child: Column(
                  children: [
                    // Visit info line:
                    Row(
                      children: [
                        // Date:
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(5.0),
                            margin: EdgeInsets.all(7.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(),
                                borderRadius: BorderRadius.circular(8.0)),
                            height: 32.0,
                            width: 120.0,

                            // Date text:
                            child: Text(
                              '${visitsDates[index]}',
                              textAlign: TextAlign.center,
                            )),
                        // Patient name:
                        Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.all(5.0),
                            margin: EdgeInsets.all(7.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(),
                                borderRadius: BorderRadius.circular(8.0)),
                            height: 32.0,
                            width: 120.0,

                            // Patient text:
                            child: Text(
                              '${visitsPatients[index]}',
                              textAlign: TextAlign.center,
                            )),
                      ],
                    ),

                    // Note:
                    Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 5.0),
                            padding: const EdgeInsets.all(15.0),
                            height: 200, // TODO: make dynamic
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // border: Border.all(),
                              borderRadius: BorderRadius.circular(20.0),
                              // boxShadow: [
                              //   BoxShadow(
                              //       color: Colors.grey.withOpacity(0.5),
                              //       spreadRadius: 5,
                              //       blurRadius: 7,
                              //       offset: Offset(0, 3))
                              // ]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // Title and note body will be contained within this:

                              children: [
                                // Title line:
                                Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Note title:
                                        Expanded(
                                            flex: 2,
                                            child: RichText(
                                                text: TextSpan(
                                                    text:
                                                        '${notesTitles[index][0]}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6))),

                                        // Note date/time:
                                        Expanded(
                                            child: Container(
                                                padding: EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  // border: Border.all(),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  border: Border.all(),
                                                ),
                                                child: Column(
                                                  children: [
                                                    // TODO: Replace placeholders:
                                                    RichText(
                                                        text: TextSpan(
                                                      text:
                                                          '${visitsTimes[index]}',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )),
                                                    RichText(
                                                        text: TextSpan(
                                                      text:
                                                          '${visitsDates[index]}',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )),
                                                  ],
                                                )))
                                      ],
                                    )),

                                // Note body:
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 8.0),
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      // Note text:
                                      child: RichText(
                                        text: TextSpan(
                                            text: '${notesBodies[index][0]}',
                                            style:
                                                TextStyle(color: Colors.black)),
                                      )),
                                ),
                              ],
                            )),
                      ],
                    ),

                    // "More" icon:
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor(purpleTheme),
        floatingActionButton: FloatingActionButton(
          backgroundColor: HexColor(blueTheme),
          child: Icon(Icons.add),
        ),
        body: getVisits());
  }
}
