import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hospital_stay_helper/class/visit.dart';
import 'package:hospital_stay_helper/components/alert_dialog.dart';
import 'package:hospital_stay_helper/components/page_description.dart';
import 'package:hospital_stay_helper/config/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospital_stay_helper/provider/timeline_provider.dart';
import 'package:hospital_stay_helper/screens/visit_detail_page.dart';
import 'package:provider/provider.dart';

class VisitsTimelinePage extends StatefulWidget {
  const VisitsTimelinePage({Key? key}) : super(key: key);

  @override
  _VisitsTimelinePageState createState() => _VisitsTimelinePageState();
}

class _VisitsTimelinePageState extends State<VisitsTimelinePage> {
  late GlobalKey<AnimatedListState> listKey;

  @override
  void initState() {
    super.initState();
    listKey = GlobalKey<AnimatedListState>();
  }

  void createVisit() {
    Provider.of<VisitTimelineProvider>(context, listen: false).createVisit();
    listKey.currentState!
        .insertItem(0, duration: const Duration(milliseconds: 500));
  }

  void deleteVisit(int visitIndex) {
    Visit temp = Provider.of<VisitTimelineProvider>(context, listen: false)
        .removeVisitAt(visitIndex);
    listKey.currentState?.removeItem(
        visitIndex,
        (_, animation) =>
            buildVisitSummary(context, temp, visitIndex, animation),
        duration: const Duration(milliseconds: 500));
  }

  getPageDescription() {
    return buildPageDescriptionColor(
      "How to use your Visits Timeline",
      "Use the Visit Timeline to keep organized records of all your medical visits.\n\nTap \"+\" to create a new visit. Tap your visit to fill in your information and start adding notes.",
      Theme.of(context).scaffoldBackgroundColor,
    );
  }

  Widget buildVisitSummary(
      BuildContext context, Visit visit, int index, animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: const Offset(0, 0),
      ).animate(animation),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VisitDetailPage(
                      key: const PageStorageKey('visitdetailpage'),
                      visitIndex: index,
                      updateVisitFunction: Provider.of<VisitTimelineProvider>(
                              context,
                              listen: false)
                          .updateVisitData,
                      updateNoteFunction: Provider.of<VisitTimelineProvider>(
                              context,
                              listen: false)
                          .updateNoteData,
                      deleteVisit: deleteVisit,
                      visit: visit,
                      createNewNote: Provider.of<VisitTimelineProvider>(context,
                              listen: false)
                          .createNote,
                      deleteNoteFunction: Provider.of<VisitTimelineProvider>(
                              context,
                              listen: false)
                          .deleteNote,
                    ))),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          color: Styles.purpleTheme,
          elevation: 5,
          child: Column(
            children: [
              // Visit date + patient name line:
              Row(
                // This makes child alignment work (patientName):
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // This aligns date/patient containers
                children: [
                  // Visit date:
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5.0),
                      margin: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(),
                        borderRadius: BorderRadius.circular(8.0),
                        // border:
                        //     Border.all(color: visitBorders, width: 2),
                        // border: Border(
                        //     bottom: BorderSide(
                        //         width: 1, color: visitBorders)),
                        // boxShadow: [
                        //   BoxShadow(
                        //       color: Colors.grey.withOpacity(0.5),
                        //       spreadRadius: 2,
                        //       blurRadius: 2,
                        //       offset: Offset(0, 3))
                        // ],
                      ),
                      height: 31.0,
                      width: 120.0,

                      // Date text:
                      child: RichText(
                        text: TextSpan(
                            text: visit.date!.isEmpty
                                ? "Visit date"
                                : '${visit.date}',
                            style: Styles.articleBodySmallBlack
                                .copyWith(color: Colors.black)),
                        textAlign: TextAlign.center,
                      )),
                  // Patient name:
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5.0),
                      margin: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(),
                        borderRadius: BorderRadius.circular(8.0),
                        // border: Border(
                        //     bottom: BorderSide(
                        //         width: 1, color: visitBorders)),
                        // boxShadow: [
                        //   BoxShadow(
                        //       color: Colors.grey.withOpacity(0.5),
                        //       spreadRadius: 2,
                        //       blurRadius: 2,
                        //       offset: Offset(0, 3))
                        // ],
                        // border:
                        //     Border.all(color: visitBorders, width: 2),
                      ),
                      height: 31.0,
                      width: 140.0,
                      // Patient text:
                      child: RichText(
                        text: TextSpan(
                            text: visit.patientName!.isEmpty
                                ? "Patient's name"
                                : '${visit.patientName}',
                            style: Styles.articleBodySmallBlack
                                .copyWith(color: Colors.black)),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
              // Healthcare provider name:
              Container(
                  height: 31,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(5.0),
                  margin: const EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(),
                    borderRadius: BorderRadius.circular(8.0),
                    // border: Border(
                    //     bottom: BorderSide(
                    //         width: 1, color: visitBorders)),
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Colors.grey.withOpacity(0.5),
                    //       spreadRadius: 2,
                    //       blurRadius: 2,
                    //       offset: Offset(0, 3))
                    // ],
                    // border:
                    //     Border.all(color: visitBorders, width: 2),
                  ),
                  // height: 32.0,
                  width: .97.sw,
                  // Patient text:
                  child: RichText(
                    text: TextSpan(
                        text: visit.healthcareProvider!.isEmpty
                            ? "Healthcare provider"
                            : '${visit.healthcareProvider}',
                        style: Styles.articleBodySmallBlack),
                    textAlign: TextAlign.center,
                  )),

              // Note/Image:
              visit.notes![0].type == 'note'
                  ? Column(
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
                            //   BoxShadow(
                            //       color: Colors.grey.withOpacity(0.5),
                            //       spreadRadius: 2,
                            //       blurRadius: 2,
                            //       offset: Offset(0, 3))
                            // ],
                            // border:
                            //     Border.all(color: visitBorders, width: 2),
                            // boxShadow: [
                            // BoxShadow(
                            //     color: Colors.grey.withOpacity(0.5),
                            //     spreadRadius: 5,
                            //     blurRadius: 7,
                            //     offset: Offset(0, 3))
                            // ]
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

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
                                  // Expanded(
                                  //     flex: 2,
                                  // child:
                                  Container(
                                      padding:
                                          const EdgeInsets.fromLTRB(9, 0, 0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 57,
                                            // width: .4.sw,
                                            child: RichText(
                                              text: TextSpan(
                                                text: visit.notes![0].title!
                                                        .isEmpty
                                                    ? "Untitled note"
                                                    : ('${visit.notes![0].title}'),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .copyWith(
                                                        color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          Text('...',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6),
                                        ],
                                        // ),
                                      )),
                                  // Note date/time:
                                  // Expanded(
                                  //     flex: 1,
                                  //     child:
                                  Container(
                                      height: 85,
                                      // width: .1.sw,
                                      alignment: Alignment.topRight,
                                      // padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        // border: Border.all(
                                        //     color: visitBorders,
                                        //     width: 2),
                                        border: Border.all(
                                            width: 1, color: Colors.grey[600]!),
                                      ),
                                      child: Column(
                                        children: [
                                          // TODO: Replace placeholders:
                                          Container(
                                            alignment: Alignment.center,
                                            height: 26.0,
                                            padding: const EdgeInsets.all(3.0),
                                            margin: const EdgeInsets.all(7.0),
                                            child: RichText(
                                                text: TextSpan(
                                              text: visit
                                                      .notes![0].time!.isEmpty
                                                  ? "Visit time"
                                                  : '${visit.notes![0].time}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            )),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: 26.0,
                                            width: 100.0,
                                            padding: const EdgeInsets.all(3.0),
                                            margin: const EdgeInsets.all(7.0),
                                            child: RichText(
                                                text: TextSpan(
                                              text: visit
                                                      .notes![0].date!.isEmpty
                                                  ? "Visit date"
                                                  : '${visit.notes![0].date}',
                                              style:
                                                  Styles.articleBodySmallBlack,
                                            )),
                                          ),
                                        ],
                                      ))
                                  // ),
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
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 1.0, vertical: 7.0),
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      // border: Border.all(),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  // Note text:
                                  child: RichText(
                                    text: TextSpan(
                                        text: visit.notes![0].body!.isEmpty
                                            ? 'Enter a description for this note...'
                                            : '${visit.notes![0].body}',
                                        style: Styles.articleBodySmallBlack),
                                  )),
                              // Three dots within note body:
                              Container(
                                  alignment: Alignment.centerLeft,
                                  // margin: EdgeInsets.symmetric(
                                  //     horizontal: 1.0, vertical: 8.0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      // border: Border.all(),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  // Note text:
                                  child: RichText(
                                    text: const TextSpan(
                                        text: '...',
                                        style: Styles.articleBodySmallBlack),
                                  ))
                              // ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(children: [
                      // NOTE whitespace:
                      Container(
                          padding: const EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width,
                          height: 250.0,
                          child: Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                  image: FileImage(File(visit.notes![0].body!)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Row(children: [
                            // Title (placeholder):
                            // Expanded(flex: 2, child: SizedBox.shrink()),
                            // Note date/time:
                            // Expanded(
                            //   flex: 1,
                            //   child:
                            Align(
                              alignment: Alignment.topRight,
                              child: Column(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // Date/time container:
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Colors.white),
                                    child: Column(
                                      children: [
                                        // TODO: Replace placeholders:
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 14),
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 26.0,
                                            width: 100.0,
                                            // padding: EdgeInsets.all(3.0),
                                            // margin: EdgeInsets.all(7.0),
                                            child: Text(
                                              visit.notes![0].time!.isEmpty
                                                  ? "Visit time"
                                                  : '${visit.notes![0].time}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        // Divider(thickness: 50, color: Colors.red),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 26.0,
                                          width: 100.0,
                                          // padding: EdgeInsets.all(3.0),
                                          // margin: EdgeInsets.all(7.0),
                                          child: Text(
                                            visit.notes![0].date!.isEmpty
                                                ? "Visit date"
                                                : '${visit.notes![0].date}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // ),
                          ])
                          //   ],
                          // ),
                          )
                    ]),

              // "More" icon:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 5),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        // Icon(Icons.add),
                        child: const Icon(Icons.delete),
                        onPressed: () async {
                          if (await showConfirm(context)) deleteVisit(index);
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  getVisits() {
    return Consumer<VisitTimelineProvider>(
      builder: (context, model, child) {
        return AnimatedList(
            key: listKey,
            initialItemCount: model.visits.length,
            itemBuilder: (context, index, animation) {
              // Visit:
              return buildVisitSummary(
                  context, model.visits[index], index, animation);
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VisitTimelineProvider>(
      builder: (context, model, child) {
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Stack(
            children: [
              Column(
                children: [getPageDescription(), Expanded(child: getVisits())],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => createVisit(),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
