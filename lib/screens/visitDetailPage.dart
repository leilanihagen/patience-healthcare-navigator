import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hospital_stay_helper/class/visit.dart';
import 'package:hospital_stay_helper/components/tapEditBox.dart';
import 'package:hospital_stay_helper/main.dart';

class VisitDetailPage extends StatefulWidget {
  final Visit visit;
  final int visitIndex;
  final Function createNewNote,
      updateVisitFunction,
      updateNoteFunction,
      deleteVisit;
  VisitDetailPage(
      {Key key,
      this.visit,
      this.visitIndex,
      this.createNewNote,
      this.updateVisitFunction,
      this.updateNoteFunction,
      this.deleteVisit})
      : super(key: key);

  @override
  _VisitDetailPageState createState() => _VisitDetailPageState();
}

class _VisitDetailPageState extends State<VisitDetailPage> {
  final String purpleTheme = "#66558E";
  final String lightPinkTheme = "#FDEBF1";
  final String darkPinkTheme = "#ED558C";
  final String blueTheme = "#44B5CD";
  // final String darkGreenTheme = "#758C20";
  final String lightGreenTheme = "#A1BF36";

  updatVisitDate(Visit visit, String dataType, String inputData) {
    setState(() {
      // widget.visit.date = inputData;
    });
    widget.updateVisitFunction(visit, dataType, inputData);

    // widget.updateVisitFunction(visit, dataType, inputData);
  }

  getNotes() {
    return ListView.builder(
        itemCount: widget.visit.notes.length,
        itemBuilder: (context, index) {
          return Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 7.0, vertical: 8.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3))
                  ]),
              // Title and note body:
              child: Wrap(
                children: [
                  // Title line:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Wrap(
                          children: [
                            TapEditBox(
                              visit: widget.visit,
                              inputData: widget.visit.notes[index].title,
                              dataType: 'title',
                              defaultText: "Untitled note",
                              isEditingVisit: false,
                              updateFunction: widget.updateNoteFunction,
                              boxDecoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .apply(
                                    bodyColor: Colors.black,
                                    displayColor: Colors.black,
                                  )
                                  .headline6,
                              noteIndex: index,
                              // TODO: make height dynamic (grow with textwrap)
                              height: 80.0,
                              width: 200.0,
                              margin: 2.0,
                              padding: 2.0,
                              shouldWrap: true,
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      ),
                      // Expanded(
                      //     // TODO: Replace placeholder:
                      //     child: RichText(
                      //         text: TextSpan(
                      //             text: '${widget.visit.notes[index].title}',
                      //             style:
                      //                 Theme.of(context).textTheme.headline6))),

                      // Note date/time:
                      Container(
                        alignment: Alignment.topRight,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            // TODO: Replace placeholders:
                            TapEditBox(
                              visit: widget.visit,
                              dataType: 'time',
                              inputData: widget.visit.notes[index].time,
                              defaultText: 'Event time',
                              isEditingVisit: false,
                              updateFunction: widget.updateNoteFunction,
                              noteIndex: index,
                              boxDecoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              height: 30.0,
                              width: 100.0,
                              // margin: 1.0,
                              padding: 3.0,
                            ),
                            TapEditBox(
                              visit: widget.visit,
                              dataType: 'date',
                              inputData: widget.visit.notes[index].date,
                              defaultText: 'Event date',
                              isEditingVisit: false,
                              updateFunction: widget.updateNoteFunction,
                              noteIndex: index,
                              boxDecoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              height: 30.0,
                              width: 100.0,
                              // margin: 1.0,
                              padding: 3.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Note body:
                  TapEditBox(
                    visit: widget.visit,
                    dataType: 'body',
                    inputData: widget.visit.notes[index].body,
                    defaultText: 'Enter a description for this note...',
                    isEditingVisit: false,
                    updateFunction: widget.updateNoteFunction,
                    noteIndex: index,
                    boxDecoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          // BoxShadow(
                          //     color: Colors.grey.withOpacity(0.5),
                          //     spreadRadius: 5,
                          //     blurRadius: 7,
                          //     offset: Offset(0, 3))
                        ]),
                    height: 100.0,
                    width: 400.0,
                    margin: 1.0,
                    padding: 3.0,
                    textAlign: TextAlign.left,
                    shouldWrap: true,
                  ),
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor(lightGreenTheme),
        floatingActionButton: FloatingActionButton(
          backgroundColor: HexColor(purpleTheme),
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              widget.createNewNote(widget.visit);
            });
            // print("NOTE COUNT: " + '${widget.visit.notes.length}');
          },
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(6.0, 25.0, 2.0, 10.0),
                  child: RichText(
                      text: TextSpan(
                          text: widget.visit.date.isEmpty
                              ? "New Visit"
                              : "${widget.visit.date}'s Visit",
                          style: TextStyle(
                              fontSize: 34, fontWeight: FontWeight.w700))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red[600]),
                      // Icon(Icons.add),
                      child: Icon(Icons.delete),
                      onPressed: () {
                        widget.deleteVisit(widget.visitIndex);
                        Navigator.pop(context);
                      }),
                )
              ],
            ),
            // Visit date and patientName line:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Visit date:
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 6,
                        blurRadius: 6,
                        offset: Offset(0, 3))
                  ]),
                  child: TapEditBox(
                    visit: widget.visit,
                    dataType: 'date',
                    inputData: widget.visit.date,
                    defaultText: 'Visit date',
                    isEditingVisit: true,
                    updateFunction: updatVisitDate,
                    boxDecoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(),
                        borderRadius: BorderRadius.circular(8.0)),
                    height: 32.0,
                    width: 120.0,
                  ),
                ),
                // Visit patientName
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 6,
                        blurRadius: 6,
                        offset: Offset(0, 3))
                  ]),
                  alignment: Alignment.centerRight,
                  child: TapEditBox(
                    visit: widget.visit,
                    dataType: 'patientName',
                    inputData: widget.visit.patientName,
                    defaultText: "Patient's name",
                    isEditingVisit: true,
                    updateFunction: widget.updateVisitFunction,
                    boxDecoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(),
                        borderRadius: BorderRadius.circular(8.0)),
                    height: 32.0,
                    width: 140.0,
                  ),
                ),
              ],
            ),

            // Add media buttons:
            // TODO (after first release): Enable Add media buttons:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.createNewNote(widget.visit);
                    });
                    // print("NOTE COUNT: " + '${widget.visit.notes.length}');
                  },
                  style:
                      ElevatedButton.styleFrom(primary: HexColor(purpleTheme)),
                  // Icon(Icons.add),
                  child: Icon(Icons.note_add),
                )
                //     IconButton(
                //         icon: Icon(Icons.camera_alt),
                //         color: Colors.white,
                //         onPressed: () => {}),
                //     IconButton(
                //         icon: Icon(Icons.mic),
                //         color: Colors.white,
                //         onPressed: () => {})
              ],
            ),

            Expanded(
                child: Column(
              children: [
                Expanded(
                  child: getNotes(),
                ),
                Container(
                  height: 10,
                )
              ],
            )),
            ElevatedButton(
              child: ListTile(
                  leading: Icon(Icons.arrow_back_ios_rounded,
                      color: Colors.white, size: 27),
                  title: Padding(
                    child: Text(
                      "Back",
                      style: TextStyle(
                          fontWeight: FontWeight.w900, color: Colors.white),
                    ),
                    padding: EdgeInsets.fromLTRB(80, 0, 50, 0),
                  )),
              onPressed: () => Navigator.pop(context),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return HexColor(blueTheme);
                    return HexColor(blueTheme); // Use the component's default.
                  },
                ),
              ),
            ), // Use Expanded to take up remaining space on screen
          ],
        ));
  }
}
