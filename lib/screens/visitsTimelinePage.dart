import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hospital_stay_helper/class/visit.dart';
import 'package:hospital_stay_helper/config/styles.dart';
import 'package:hospital_stay_helper/main.dart';
import 'package:hospital_stay_helper/plugins/firebase_analytics.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hospital_stay_helper/screens/visitDetailPage.dart';
import '../class/sharePref.dart';

class VisitsTimelinePage extends StatefulWidget {
  VisitsTimelinePage({Key key}) : super(key: key);

  @override
  _VisitsTimelinePageState createState() => _VisitsTimelinePageState();
}

class _VisitsTimelinePageState extends State<VisitsTimelinePage> {
  List<Visit> visits = [];
  GlobalKey<AnimatedListState> listKey;

  // @override
  // void initState() {
  //   super.initState();
  //
  // }
  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  Future<bool> showConfirm() async {
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirm delete?"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text("YES")),
            ],
          );
        });
  }

  _loadSaved() async {
    if (await MySharedPreferences.instance.getBoolValue('first_visit') ==
        false) {
      print('false');
      setState(() {
        visits = [Visit.fromTemplate()];
      });
      updateVisit();
      MySharedPreferences.instance.setBoolValue('first_visit', true);
    } else {
      String _savedVisits =
          await MySharedPreferences.instance.getStringValue('visits');
      if (_savedVisits.isNotEmpty) {
        Iterable tmp = jsonDecode(_savedVisits);
        setState(() {
          visits = List<Visit>.from(tmp.map((model) => Visit.fromJson(model)));
        });
      }
    }
    setState(() {
      listKey = GlobalKey<AnimatedListState>();
    });
  }

  void updateVisit() async {
    // print(jsonEncode(visits));
    await MySharedPreferences.instance
        .setStringValue('visits', jsonEncode(visits));
  }

  void createVisit() {
    listKey.currentState
        .insertItem(0, duration: const Duration(milliseconds: 500));
    visits.insert(0, Visit([VisitNote()]));
    updateVisit();
    observer.analytics.logEvent(name: 'create_visit');
  }

  void deleteVisit(int visitIndex) {
    Visit temp = visits.removeAt(visitIndex);
    listKey.currentState?.removeItem(visitIndex,
        (_, animation) => visitWidget(context, temp, visitIndex, animation),
        duration: const Duration(milliseconds: 500));
    updateVisit();
    observer.analytics.logEvent(name: 'delete_visit');
  }

  void createNote(Visit visit, String type, String path) {
    if (type == 'note')
      setState(() {
        visit.notes.insert(0, VisitNote());
      });
    if (type == 'image')
      setState(() {
        visit.notes.insert(0, VisitNote.fromPicture(path));
      });
    updateVisit();
    observer.analytics
        .logEvent(name: 'create_note', parameters: {'type': type});
  }

  VisitNote deleteNote(Visit visit, int noteIndex) {
    VisitNote temp = visit.notes.removeAt(noteIndex);
    updateVisit();
    observer.analytics
        .logEvent(name: 'delete_note', parameters: {'type': temp.type});
    return temp;
  }

  getPageDescription() {
    return Padding(
        child: Card(
          color: Colors.white,
          child: Padding(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(
                  "Welcome to your Visit Timeline. Here, you can keep organized records of each hospital visit.\n",
                  textAlign: TextAlign.left,
                  style: Styles.instruction,
                ),
                Text(
                  'Tap "+"" to create a new visit. Tap your visit to edit and add notes. On each, tap any piece of information to customize it.',
                  textAlign: TextAlign.left,
                  style: Styles.instruction,
                ),
              ]),
              padding: EdgeInsets.fromLTRB(15, 11, 15, 11)),
        ),
        padding: EdgeInsets.fromLTRB(0, 12, 0, 12));
  }

  void updateVisitData(Visit visit, String type, String data) {
    setState(() {
      switch (type) {
        case 'date':
          {
            visit.date = data;
          }
          break;
        case 'patientName':
          {
            visit.patientName = data;
          }
          break;
      }
    });
    updateVisit();
  }

  // update note here, pass to detailpage:
  void updateNoteData(Visit visit, int noteIndex, String type, String data) {
    setState(() {
      switch (type) {
        case 'title':
          {
            visit.notes[noteIndex].title = data;
          }
          break;
        case 'time':
          {
            visit.notes[noteIndex].time = data;
          }
          break;
        case 'date':
          {
            visit.notes[noteIndex].date = data;
          }
          break;
        case 'body':
          {
            visit.notes[noteIndex].body = data;
          }
          break;
      }
    });
    updateVisit();
  }

  Widget visitWidget(BuildContext context, Visit visit, int index, animation) {
    return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset(0, 0),
        ).animate(animation),
        child: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VisitDetailPage(
                          key: PageStorageKey('visitdetailpage'),
                          visitIndex: index,
                          updateVisitFunction: updateVisitData,
                          updateNoteFunction: updateNoteData,
                          deleteVisit: deleteVisit,
                          visit: visit,
                          createNewNote: createNote,
                          deleteNoteFunction: deleteNote,
                        ))),
            child: visit.notes[0].type == 'note'
                ? Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    decoration: BoxDecoration(
                        color: Styles.lightGreenTheme,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3))
                        ]),
                    // height: 310,
                    child: Column(
                      children: [
                        // Visit info line:
                        Row(
                          // This makes child alignment work (patientName):
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // This aligns date/patient containers
                          children: [
                            // Date:
                            // TapEditBox(
                            //   visit: visits[index],
                            //   dataType: 'date',
                            //   inputData: visits[index].date,
                            //   defaultText: 'Visit date',
                            //   isEditingVisit: true,
                            //   updateFunction: updateVisitData,
                            //   boxDecoration: BoxDecoration(
                            //       color: Colors.white,
                            //       // border: Border.all(),
                            //       borderRadius: BorderRadius.circular(8.0)),
                            //   height: 32.0,
                            //   width: 120.0,
                            // ),
                            Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5.0),
                                margin: EdgeInsets.all(7.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    // border: Border.all(),
                                    borderRadius: BorderRadius.circular(8.0)),
                                height: 32.0,
                                width: 120.0,

                                // Date text:
                                child: RichText(
                                  text: TextSpan(
                                      text: visit.date.isEmpty
                                          ? "Visit date"
                                          : '${visit.date}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17)),
                                  textAlign: TextAlign.center,
                                )),
                            // Patient name:
                            // Container(
                            //   alignment: Alignment.topRight,
                            // child: TapEditBox(
                            //   visit: visits[index],
                            //   dataType: 'patientName',
                            //   inputData: visits[index].patientName,
                            //   defaultText: "Enter name",
                            //   isEditingVisit: true,
                            //   updateFunction: updateVisitData,
                            //   boxDecoration: BoxDecoration(
                            //       color: Colors.white,
                            //       // border: Border.all(),
                            //       borderRadius: BorderRadius.circular(8.0)),
                            //   height: 32.0,
                            //   width: 140.0,
                            // ),
                            // ),
                            Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5.0),
                                margin: EdgeInsets.all(7.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    // border: Border.all(),
                                    borderRadius: BorderRadius.circular(8.0)),
                                height: 32.0,
                                width: 140.0,
                                // Patient text:
                                child: RichText(
                                  text: TextSpan(
                                      text: visit.patientName.isEmpty
                                          ? "Patient's name"
                                          : '${visit.patientName}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17)),
                                  textAlign: TextAlign.center,
                                )),
                          ],
                        ),

                        // Note:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 5.0),
                              padding: const EdgeInsets.all(15.0),
                              // height: 200, // TODO: make dynamic
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(),
                                borderRadius: BorderRadius.circular(20.0),
                                // boxShadow: [
                                // BoxShadow(
                                //     color: Colors.grey.withOpacity(0.5),
                                //     spreadRadius: 5,
                                //     blurRadius: 7,
                                //     offset: Offset(0, 3))
                                // ]
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,

                                // Title date/time line, size controlled with Expanded(flex):
                                children: [
                                  // Title line:
                                  // Expanded(
                                  //     flex: 2,
                                  //     child:
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Note title:
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                            padding:
                                                EdgeInsets.fromLTRB(9, 0, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    height: 57,
                                                    // width: .4.sw,
                                                    child: RichText(
                                                        text: TextSpan(
                                                            text: visit
                                                                    .notes[0]
                                                                    .title
                                                                    .isEmpty
                                                                ? "Untitled note"
                                                                : ('${visit.notes[0].title}'),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6))),
                                                Text('...',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6),
                                              ],
                                            ),
                                          )),
                                      // Note date/time:
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              height: 85,
                                              // width: .1.sw,
                                              alignment: Alignment.topRight,
                                              // padding: EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                border: Border.all(),
                                              ),
                                              child: Column(
                                                children: [
                                                  // TODO: Replace placeholders:
                                                  Container(
                                                    alignment: Alignment.center,
                                                    height: 26.0,
                                                    padding:
                                                        EdgeInsets.all(3.0),
                                                    margin: EdgeInsets.all(7.0),
                                                    child: RichText(
                                                        text: TextSpan(
                                                      text: visit.notes[0].time
                                                              .isEmpty
                                                          ? "Visit time"
                                                          : '${visit.notes[0].time}',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 17),
                                                    )),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    height: 26.0,
                                                    width: 100.0,
                                                    padding:
                                                        EdgeInsets.all(3.0),
                                                    margin: EdgeInsets.all(7.0),
                                                    child: RichText(
                                                        text: TextSpan(
                                                      text: visit.notes[0].date
                                                              .isEmpty
                                                          ? "Visit date"
                                                          : '${visit.notes[0].date}',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 17),
                                                    )),
                                                  ),
                                                ],
                                              ))),
                                    ],
                                    // )
                                  ),

                                  // Note body:
                                  // Expanded(
                                  //   flex: 2,

                                  // child:
                                  Container(
                                      height: 58,
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 8.0),
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          // border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      // Note text:
                                      child: RichText(
                                        text: TextSpan(
                                            text: visit.notes[0].body.isEmpty
                                                ? 'Enter a description for this note...'
                                                : '${visit.notes[0].body}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17)),
                                      )),
                                  // Three dots within note body:
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      // margin: EdgeInsets.symmetric(
                                      //     horizontal: 1.0, vertical: 8.0),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 9.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          // border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      // Note text:
                                      child: RichText(
                                        text: TextSpan(
                                            text: '...',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17)),
                                      ))
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // "More" icon:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                            IconButton(
                                // Icon(Icons.add),
                                icon: Icon(Icons.delete),
                                onPressed: () async {
                                  if (await showConfirm()) deleteVisit(index);
                                }),
                          ],
                        ),
                      ],
                    ),
                  )
                // If image note is first in visit:
                : Container(
                    // TODO: refactor/untangle this!!:
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    decoration: BoxDecoration(
                        color: Styles.lightGreenTheme,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3))
                        ]),
                    // height: 310,
                    child: Column(children: [
                      // Visit info line:
                      Row(
                        // This makes child alignment work (patientName):
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // This aligns date/patient containers
                        children: [
                          // Date:
                          // TapEditBox(
                          //   visit: visits[index],
                          //   dataType: 'date',
                          //   inputData: visits[index].date,
                          //   defaultText: 'Visit date',
                          //   isEditingVisit: true,
                          //   updateFunction: updateVisitData,
                          //   boxDecoration: BoxDecoration(
                          //       color: Colors.white,
                          //       // border: Border.all(),
                          //       borderRadius: BorderRadius.circular(8.0)),
                          //   height: 32.0,
                          //   width: 120.0,
                          // ),
                          Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(5.0),
                              margin: EdgeInsets.all(7.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              height: 32.0,
                              width: 120.0,

                              // Date text:
                              child: RichText(
                                text: TextSpan(
                                    text: visit.date.isEmpty
                                        ? "Visit date"
                                        : '${visit.date}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17)),
                                textAlign: TextAlign.center,
                              )),
                          // Patient name:
                          // Container(
                          //   alignment: Alignment.topRight,
                          // child: TapEditBox(
                          //   visit: visits[index],
                          //   dataType: 'patientName',
                          //   inputData: visits[index].patientName,
                          //   defaultText: "Enter name",
                          //   isEditingVisit: true,
                          //   updateFunction: updateVisitData,
                          //   boxDecoration: BoxDecoration(
                          //       color: Colors.white,
                          //       // border: Border.all(),
                          //       borderRadius: BorderRadius.circular(8.0)),
                          //   height: 32.0,
                          //   width: 140.0,
                          // ),
                          // ),
                          Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(5.0),
                              margin: EdgeInsets.all(7.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              height: 32.0,
                              width: 140.0,
                              // Patient text:
                              child: RichText(
                                text: TextSpan(
                                    text: visit.patientName.isEmpty
                                        ? "Patient's name"
                                        : '${visit.patientName}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17)),
                                textAlign: TextAlign.center,
                              )),
                        ],
                      ),

                      // Note:
                      Column(children: [
                        // NOTE whitespace:
                        Container(
                          padding: EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width,
                          height: 250.0,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: DecorationImage(
                                    image: FileImage(File(visit.notes[0].body)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Row(children: [
                                // Title (placeholder):
                                Expanded(flex: 2, child: SizedBox.shrink()),
                                // Note date/time:
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Column(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        // Date/time container:
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 10, 10, 0),
                                          padding: EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                              border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              color: Colors.white),
                                          child: Column(
                                            children: [
                                              // TODO: Replace placeholders:
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 14),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 26.0,
                                                  width: 100.0,
                                                  // padding: EdgeInsets.all(3.0),
                                                  // margin: EdgeInsets.all(7.0),
                                                  child: RichText(
                                                      text: TextSpan(
                                                    text: visit.notes[0].time
                                                            .isEmpty
                                                        ? "Visit time"
                                                        : '${visit.notes[0].time}',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17),
                                                  )),
                                                ),
                                              ),
                                              // Divider(thickness: 50, color: Colors.red),
                                              Container(
                                                alignment: Alignment.center,
                                                height: 26.0,
                                                width: 100.0,
                                                // padding: EdgeInsets.all(3.0),
                                                // margin: EdgeInsets.all(7.0),
                                                child: RichText(
                                                    text: TextSpan(
                                                  text: visit
                                                          .notes[0].date.isEmpty
                                                      ? "Visit date"
                                                      : '${visit.notes[0].date}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ])
                            ],
                          ),
                        )
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          IconButton(
                              // Icon(Icons.add),
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                if (await showConfirm()) deleteVisit(index);
                              }),
                        ],
                      ),
                    ]))));

    //                     Container(
    //                       margin: const EdgeInsets.symmetric(
    //                           horizontal: 8.0, vertical: 5.0),
    //                       padding: const EdgeInsets.all(15.0),
    //                       height: 200, // TODO: make dynamic
    //                       decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         // border: Border.all(),
    //                         borderRadius: BorderRadius.circular(20.0),
    //                         // boxShadow: [
    //                         // BoxShadow(
    //                         //     color: Colors.grey.withOpacity(0.5),
    //                         //     spreadRadius: 5,
    //                         //     blurRadius: 7,
    //                         //     offset: Offset(0, 3))
    //                         // ]
    //                       ),
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                         // Title and note body will be contained within this:

    //                         children: [
    //                           // Title line:
    //                           Expanded(
    //                               flex: 2,
    //                               child: Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   // Note title:
    //                                   // Expanded(
    //                                   //     flex: 2,
    //                                   //     child: RichText(
    //                                   //         text: TextSpan(
    //                                   //             text: visit.notes[0].title
    //                                   //                     .isEmpty
    //                                   //                 ? "Untitled note"
    //                                   //                 : ('${visit.notes[0].title}'),
    //                                   //             style: Theme.of(context)
    //                                   //                 .textTheme
    //                                   //                 .headline6))),
    //                                   // Note date/time:
    //                                   Expanded(
    //                                       child: Container(
    //                                           height: 85,
    //                                           alignment: Alignment.topRight,
    //                                           // padding: EdgeInsets.all(8.0),
    //                                           decoration: BoxDecoration(
    //                                             borderRadius:
    //                                                 BorderRadius.circular(20.0),
    //                                             border: Border.all(),
    //                                           ),
    //                                           child: Column(
    //                                             children: [
    //                                               // TODO: Replace placeholders:
    //                                               Container(
    //                                                 alignment: Alignment.center,
    //                                                 height: 26.0,
    //                                                 width: 100.0,
    //                                                 padding:
    //                                                     EdgeInsets.all(3.0),
    //                                                 margin: EdgeInsets.all(7.0),
    //                                                 child: RichText(
    //                                                     text: TextSpan(
    //                                                   text: visit.notes[0].time
    //                                                           .isEmpty
    //                                                       ? "Visit time"
    //                                                       : '${visit.notes[0].time}',
    //                                                   style: TextStyle(
    //                                                       color: Colors.black,
    //                                                       fontSize: 17),
    //                                                 )),
    //                                               ),
    //                                               Container(
    //                                                 alignment: Alignment.center,
    //                                                 height: 26.0,
    //                                                 width: 100.0,
    //                                                 padding:
    //                                                     EdgeInsets.all(3.0),
    //                                                 margin: EdgeInsets.all(7.0),
    //                                                 child: RichText(
    //                                                     text: TextSpan(
    //                                                   text: visit.notes[0].date
    //                                                           .isEmpty
    //                                                       ? "Visit date"
    //                                                       : '${visit.notes[0].date}',
    //                                                   style: TextStyle(
    //                                                       color: Colors.black,
    //                                                       fontSize: 17),
    //                                                 )),
    //                                               ),
    //                                             ],
    //                                           ))),
    //                                 ],
    //                               )),

    //                           // Note body:
    //                           Expanded(
    //                             flex: 2,
    //                             child: Container(
    //                               padding: EdgeInsets.all(10.0),
    //                               width: MediaQuery.of(context).size.width,
    //                               height: 250.0,
    //                               child: Stack(
    //                                 children: [
    //                                   Container(
    //                                     decoration: BoxDecoration(
    //                                       borderRadius:
    //                                           BorderRadius.circular(20.0),
    //                                       image: DecorationImage(
    //                                         image: FileImage(
    //                                             File(visit.notes[0].body)),
    //                                         fit: BoxFit.cover,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   // Align(
    //                                   //   alignment: Alignment.bottomRight,
    //                                   //   child: Padding(
    //                                   //     padding: EdgeInsets.all(12.0),
    //                                   //     child: Container(
    //                                   //       height: 30.0,
    //                                   //       width: 30.0,
    //                                   //       decoration: BoxDecoration(
    //                                   //         shape: BoxShape.circle,
    //                                   //         color: Colors.white,
    //                                   //       ),
    //                                   //       child: InkWell(
    //                                   //         onTap: () async {
    //                                   //           if (await showConfirm())
    //                                   //             deleteVisit(index);
    //                                   //         },
    //                                   //         child: Icon(
    //                                   //           Icons.delete,
    //                                   //           size: 16.0,
    //                                   //         ),
    //                                   //       ),
    //                                   //     ),
    //                                   //   ),
    //                                   // )
    //                                 ],
    //                               ),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    // "More" icon:

    //               ],
    //             ),
    //           ),
    // //   ),
    // );
  }

  getVisits() {
    return AnimatedList(
        key: listKey,
        initialItemCount: visits.length,
        itemBuilder: (context, index, animation) {
          // Visit:
          return visitWidget(context, visits[index], index, animation);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.purpleTheme,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniEndDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Styles.blueTheme,
          child: Icon(Icons.add),
          onPressed: () {
            createVisit();
          },
        ),
        body: Column(
          children: [
            getPageDescription(),
            Expanded(child: getVisits()),
          ],
        ));
  }
}
