import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hospital_stay_helper/class/visit.dart';
import 'package:hospital_stay_helper/main.dart';

class VisitDetailPage extends StatefulWidget {
  final Visit visit;
  final Function createNewNote;
  VisitDetailPage({Key key, this.visit, this.createNewNote}) : super(key: key);

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

  getNotes() {
    return ListView.builder(
        itemCount: widget.visit.notes.length,
        itemBuilder: (context, index) {
          return Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              padding: const EdgeInsets.all(20.0),
              height: 200, // TODO: make dynamic
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)),
              // Title and note body:
              child: Column(
                children: [
                  // Title line:
                  Row(
                    children: [
                      // Note title:
                      Expanded(
                          // TODO: Replace placeholder:
                          child: RichText(
                              text: TextSpan(
                                  text: '${widget.visit.notes[index].title}',
                                  style:
                                      Theme.of(context).textTheme.headline6))),

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
                                text: '${widget.visit.notes[index].time}',
                                style: TextStyle(color: Colors.black),
                              )),
                              RichText(
                                  text: TextSpan(
                                text: '${widget.visit.notes[index].date}',
                                style: TextStyle(color: Colors.black),
                              )),
                            ],
                          ))
                    ],
                  )
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
            print("NOTE COUNT: " + '${widget.visit.notes.length}');
          },
        ),
        body: Column(
          children: [
            // TODO (after first release): Enable Add media buttons:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        widget.createNewNote(widget.visit);
                      });
                      print("NOTE COUNT: " + '${widget.visit.notes.length}');
                    },
                    style: ElevatedButton.styleFrom(
                        primary: HexColor(purpleTheme)),
                    child: Row(
                      children: [
                        // Icon(Icons.add),
                        Icon(Icons.note_add),
                      ],
                    ))
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
                child:
                    getNotes()), // Use Expanded to take up remaining space on screen
          ],
        ));
  }
}
