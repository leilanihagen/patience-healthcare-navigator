import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hospital_stay_helper/class/visit.dart';
import 'package:hospital_stay_helper/config/styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'package:hospital_stay_helper/components/visitTapEditBox.dart';

class VisitDetailPage extends StatefulWidget {
  final Visit visit;
  final int visitIndex;
  final Function createNewNote,
      deleteNoteFunction,
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
      this.deleteNoteFunction,
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
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final picker = ImagePicker();
  Future<bool> showConfirm() async {
    bool result = await showDialog(
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
                  child: Text("Yes")),
            ],
          );
        });
    return result;
  }

  getImage() async {
    PickedFile imageFile = await picker.getImage(source: ImageSource.gallery);
    if (imageFile == null) return;
    File tmpFile = File(imageFile.path);
    final appDir = await getApplicationDocumentsDirectory();
    final filename = imageFile.path.split('/').last;
    final File newImage = await tmpFile.copy('${appDir.path}/$filename');
    createNewNote('image', newImage.path);
  }

  Future<Null> _selectDate(
      BuildContext context, String selectedDate, int index) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateFormat.yMd().parse(selectedDate),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));
    if (picked != null)
      widget.updateNoteFunction(
          widget.visit, index, 'date', DateFormat.yMd().format(picked));
  }

  Future<Null> _selectVisitDate(
      BuildContext context, String selectedDate) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateFormat.yMd().parse(selectedDate),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));
    if (picked != null)
      setState(() {
        widget.updateVisitFunction(
            widget.visit, 'date', DateFormat.yMd().format(picked));
      });
  }

  Future<Null> _selectTime(
      BuildContext context, String selectedTime, int index) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(DateFormat.Hm().parse(selectedTime)),
        initialEntryMode: TimePickerEntryMode.dial);
    if (picked != null)
      setState(() {
        widget.updateNoteFunction(
            widget.visit, index, 'time', picked.format(context));
      });
  }

  updatVisitDate(Visit visit, String dataType, String inputData) {
    setState(() {
      // widget.visit.date = inputData;
    });
    widget.updateVisitFunction(visit, dataType, inputData);
    // widget.updateVisitFunction(visit, dataType, inputData);
  }

  deleteNote(int index) async {
    if (await showConfirm()) {
      if (widget.visit.notes.length == 1) {
        widget.deleteVisit(widget.visitIndex);
        Navigator.pop(context);
      } else {
        VisitNote temp = widget.deleteNoteFunction(widget.visit, index);

        listKey.currentState.removeItem(index,
            (_, animation) => noteWidget(context, temp, index, animation),
            duration: const Duration(milliseconds: 200));
      }
    }
  }

  createNewNote(String type, String path) {
    listKey.currentState
        .insertItem(0, duration: const Duration(milliseconds: 500));
    widget.createNewNote(widget.visit, type, path);
  }

  noteWidget(BuildContext context, VisitNote note, int index, animation) {
    if (note.type == 'note')
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset(0, 0),
        ).animate(animation),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 8.0),
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
                          VisitTapEditBox(
                            visit: widget.visit,
                            inputData: note.title,
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
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          // TODO: Replace placeholders:
                          GestureDetector(
                            onTap: () => _selectTime(context, note.time, index),
                            child: Text(note.time),
                          ),
                          Divider(thickness: 50, color: Colors.red),
                          GestureDetector(
                            onTap: () => _selectDate(context, note.date, index),
                            child: Container(
                              child: Text(note.date),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                // Note body:
                VisitTapEditBox(
                  visit: widget.visit,
                  dataType: 'body',
                  inputData: note.body,
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
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => deleteNote(index),
                    icon: Icon(Icons.delete),
                  ),
                )
              ],
            )),
      );
    else if (note.type == 'image')
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset(0, 0),
        ).animate(animation),
        child: Container(
          padding: EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width,
          height: 250.0,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: FileImage(File(note.body)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () => deleteNote(index),
                      child: Icon(
                        Icons.delete,
                        size: 16.0,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
  }

  Widget getNotes() {
    return AnimatedList(
        key: listKey,
        initialItemCount: widget.visit.notes.length.compareTo(0),
        itemBuilder: (context, index, animation) {
          return noteWidget(
              context, widget.visit.notes[index], index, animation);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.lightGreenTheme,
        floatingActionButton: FloatingActionButton(
            backgroundColor: HexColor(purpleTheme),
            child: Icon(Icons.add),
            onPressed: () => createNewNote('note', '')),
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
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 3))
                      ]),
                  // onTap: () => _selectDate(
                  //     context, widget.visit.date, index),
                  child: GestureDetector(
                    onTap: () => _selectVisitDate(context, widget.visit.date),
                    child: Text(
                      widget.visit.date,
                      style: Styles.articleBody,
                    ),
                  ),
                ),
                // Visit date:
                // Container(
                //   decoration: BoxDecoration(boxShadow: [
                //     BoxShadow(
                //         color: Colors.grey.withOpacity(0.2),
                //         spreadRadius: 6,
                //         blurRadius: 6,
                //         offset: Offset(0, 3))
                //   ]),
                //   child: VisitTapEditBox(
                //     visit: widget.visit,
                //     dataType: 'date',
                //     inputData: widget.visit.date,
                //     defaultText: 'Visit date',
                //     isEditingVisit: true,
                //     updateFunction: updatVisitDate,
                //     boxDecoration: BoxDecoration(
                //         color: Colors.white,
                //         // border: Border.all(),
                //         borderRadius: BorderRadius.circular(8.0)),
                //     height: 32.0,
                //     width: 120.0,
                //   ),
                // ),
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
                  child: VisitTapEditBox(
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
                  onPressed: () => createNewNote('note', ''),
                  style:
                      ElevatedButton.styleFrom(primary: HexColor(purpleTheme)),

                  // Icon(Icons.add),
                  child: Icon(Icons.note_add),
                ),
                Container(
                  width: 50,
                ),
                ElevatedButton(
                  onPressed: () => getImage(),
                  style:
                      ElevatedButton.styleFrom(primary: HexColor(purpleTheme)),
                  // Icon(Icons.add),
                  child: Icon(Icons.image),
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
                    child: Styles.backButton,
                    padding: EdgeInsets.fromLTRB(80, 0, 50, 0),
                  )),
              onPressed: () => Navigator.pop(context),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Styles.blueTheme;
                    return Styles.blueTheme; // Use the component's default.
                  },
                ),
              ),
            ), // Use Expanded to take up remaining space on screen
          ],
        ));
  }
}
