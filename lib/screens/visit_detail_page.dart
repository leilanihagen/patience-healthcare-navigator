import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hospital_stay_helper/class/visit.dart';
import 'package:hospital_stay_helper/components/alert_dialog.dart';
import 'package:hospital_stay_helper/components/buttons.dart';
import 'package:hospital_stay_helper/components/expandable_FAB.dart';
import 'package:hospital_stay_helper/config/styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'package:hospital_stay_helper/components/visit_tap_edit_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageFullScreenView extends StatelessWidget {
  final Image? image;

  const ImageFullScreenView({this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.purpleTheme,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
      body: InteractiveViewer(
        child: Center(child: Hero(tag: 'imageView', child: image!)),
        // onTap: () {
        //   Navigator.pop(context);
        // },
      ),
    );
  }
}

class VisitDetailPage extends StatefulWidget {
  final Visit? visit;
  final int? visitIndex;
  final Function? createNewNote,
      deleteNoteFunction,
      updateVisitFunction,
      updateNoteFunction,
      deleteVisit;
  const VisitDetailPage(
      {Key? key,
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
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final picker = ImagePicker();
  // Future<bool> showConfirm() async {
  //   bool result = await showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("Confirm delete?"),
  //           actions: [
  //             TextButton(
  //                 onPressed: () => Navigator.pop(context, false),
  //                 child: Text("Cancel")),
  //             TextButton(
  //                 onPressed: () => Navigator.pop(context, true),
  //                 child: Text("Yes")),
  //           ],
  //         );
  //       });
  //   return result;
  // }

  getImage() async {
    XFile? imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) return;
    File tmpFile = File(imageFile.path);
    final appDir = await getApplicationDocumentsDirectory();
    final filename = imageFile.path.split('/').last;
    final File newImage = await tmpFile.copy('${appDir.path}/$filename');
    createNewNote('image', newImage.path);
  }

  Future<void> _selectDate(
      BuildContext context, String selectedDate, int index) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateFormat.yMd().parse(selectedDate),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));
    if (picked != null) {
      widget.updateNoteFunction!(
          widget.visit, index, 'date', DateFormat.yMd().format(picked));
    }
  }

  Future<void> _selectVisitDate(
      BuildContext context, String selectedDate) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateFormat.yMd().parse(selectedDate),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));
    if (picked != null) {
      setState(() {
        widget.updateVisitFunction!(
            widget.visit, 'date', DateFormat.yMd().format(picked));
      });
    }
  }

  Future<void> _selectTime(
      BuildContext context, String selectedTime, int index) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(DateFormat.Hm().parse(selectedTime)),
        initialEntryMode: TimePickerEntryMode.dial);
    if (picked != null) {
      setState(() {
        widget.updateNoteFunction!(
            widget.visit, index, 'time', picked.format(context));
      });
    }
  }

  updatVisitDate(Visit visit, String dataType, String inputData) {
    widget.updateVisitFunction!(visit, dataType, inputData);
    // widget.updateVisitFunction(visit, dataType, inputData);
  }

  deleteNote(int index) async {
    if (await (showConfirm(context))) {
      if (widget.visit!.notes!.length == 1) {
        widget.deleteVisit!(widget.visitIndex);
        Navigator.pop(context);
      } else {
        VisitNote? temp = widget.deleteNoteFunction!(widget.visit, index);

        listKey.currentState!.removeItem(index,
            (_, animation) => noteWidget(context, temp!, index, animation),
            duration: const Duration(milliseconds: 200));
      }
    }
  }

  createNewNote(String type, String path) {
    listKey.currentState!
        .insertItem(0, duration: const Duration(milliseconds: 500));
    widget.createNewNote!(widget.visit, type, path);
  }

  noteWidget(BuildContext context, VisitNote note, int index, animation) {
    if (note.type == 'note') {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: const Offset(0, 0),
        ).animate(animation),
        child: Card(
            elevation: 5,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title line:
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 5,
                        child: Container(
                          alignment: Alignment.topLeft,
                          child:
                              // Wrap(
                              //   children: [
                              VisitTapEditBox(
                            visit: widget.visit,
                            inputData: note.title,
                            dataType: 'title',
                            defaultText: "Untitled note",
                            isEditingVisit: false,
                            updateFunction: widget.updateNoteFunction,
                            boxDecoration: BoxDecoration(
                                // color: Colors.white,
                                // border: Border.all(),
                                borderRadius: BorderRadius.circular(8.0)),
                            mainTextStyle: Theme.of(context)
                                .textTheme
                                .apply(
                                  bodyColor: Colors.black,
                                )
                                .headline6,
                            defaultTextStyle: Theme.of(context)
                                .textTheme
                                .apply(
                                  bodyColor: Colors.grey[700],
                                )
                                .headline6,
                            noteIndex: index,
                            // TODO: make height dynamic (grow with textwrap)
                            height: 80.0,
                            // width: 200.0,
                            margin: 2.0,
                            padding: 2.0,
                            shouldWrap: true,
                            textAlign: TextAlign.left,
                          ),
                          //   ],
                          // ),
                        )),
                    // Expanded(
                    //     // TODO: Replace placeholder:
                    //     child: RichText(
                    //         text: TextSpan(
                    //             text: '${widget.visit.notes[index].title}',
                    //             style:
                    //                 Theme.of(context).textTheme.headline6))),

                    // Note date/time:
                    // Align(
                    //   alignment: Alignment.topRight,
                    // child:
                    // Expanded(
                    //   flex: 2,
                    //   child:
                    Container(
                      width: 120,
                      margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[600]!),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // TODO: Replace placeholders:
                          GestureDetector(
                            onTap: () =>
                                _selectTime(context, note.time!, index),
                            child: Text(
                              note.time!,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                          ),
                          const Divider(thickness: 10, color: Colors.white),
                          GestureDetector(
                            onTap: () =>
                                _selectDate(context, note.date!, index),
                            child: Text(note.date!,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          )
                        ],
                      ),
                    ),
                    // ),
                    // ),
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
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Colors.grey.withOpacity(0.5),
                    //       spreadRadius: 5,
                    //       blurRadius: 7,
                    //       offset:const Offset(0, 3))
                    // ],
                  ),
                  // height: 100.0,
                  width: .87.sw,
                  margin: 1.0,
                  padding: 3.0,
                  defaultTextStyle: Styles.articleBodySmallGreyed,
                  textAlign: TextAlign.left,
                  shouldWrap: true,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => deleteNote(index),
                    icon:
                        const Icon(Icons.delete, size: 22, color: Colors.black),
                  ),
                )
              ],
            )),
      );
    } else if (note.type == 'image') {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: const Offset(0, 0),
        ).animate(animation),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width, //
          height: 250.0,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ImageFullScreenView(
                        image: Image.file((File(note.body!))));
                  }));
                },
                child: Hero(
                  tag: 'imageView',
                  child: Container(
                    // width: 112,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: FileImage(File(note.body!)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              // Note date/time:
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Date/time container:
                  Container(
                    width: 120,
                    margin: const EdgeInsets.all(13.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        // TODO: Replace placeholders:
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
                          child: GestureDetector(
                            onTap: () =>
                                _selectTime(context, note.time!, index),
                            child: Text(note.time!,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          ),
                        ),
                        // Divider(thickness: 50, color: Colors.red),
                        GestureDetector(
                          onTap: () => _selectDate(context, note.date!, index),
                          child: Text(note.date!,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: InkWell(
                          onTap: () => deleteNote(index),
                          child: const Icon(
                            Icons.delete,
                            size: 22.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }
  }

  Widget getNotes() {
    return AnimatedList(
        key: listKey,
        initialItemCount: widget.visit!.notes!.length,
        itemBuilder: (context, index, animation) {
          return noteWidget(
              context, widget.visit!.notes![index], index, animation);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.purpleTheme,
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: Styles.modestPink,
      //     foregroundColor: Styles.shadowWhite,
      //     child: Icon(Icons.add),
      //     onPressed: () => createNewNote('note', '')),
      floatingActionButton: ExpandableFab(
        distance: 100,
        children: [
          ActionButton(
              iconSize: 30,
              onPressed: () => createNewNote('note', ''),
              icon: const Icon(
                Icons.note_add,
                color: Styles.blueTheme,
              )),
          ActionButton(
            iconSize: 30,
            onPressed: () => getImage(),
            icon: const Icon(
              Icons.image,
              color: Styles.blueTheme,
            ),
          )
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Title and trashcan line:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 25.0, 2.0, 10.0),
                child: RichText(
                    text: TextSpan(
                        text: widget.visit!.date!.isEmpty
                            ? "New Visit"
                            : "${widget.visit!.date}'s Visit",
                        style: const TextStyle(
                            fontSize: 34, fontWeight: FontWeight.w700))),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    // Icon(Icons.add),
                    child: const Icon(Icons.delete),
                    onPressed: () async {
                      if (await showConfirm(context)) {
                        widget.deleteVisit!(widget.visitIndex);
                        Navigator.pop(context);
                      }
                    }),
              )
            ],
          ),
          // Visit date and patientName line:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _selectVisitDate(context, widget.visit!.date!),
                child: Card(
                  elevation: 5,
                  margin: const EdgeInsets.only(left: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  color: Colors.white,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    height: 45,
                    child: Text(
                      widget.visit!.date!,
                      style: Styles.articleBodySmallBlack,
                    ),
                  ),
                ),
              ),
              // Visit patientName
              Card(
                elevation: 5,
                margin: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Colors.white,
                child: VisitTapEditBox(
                  visit: widget.visit,
                  dataType: 'patientName',
                  inputData: widget.visit!.patientName,
                  defaultText: "Patient's name...",
                  isEditingVisit: true,
                  updateFunction: widget.updateVisitFunction,

                  defaultTextStyle: Styles.articleBodySmallGreyed,
                  // height: 32.0,
                  width: .5.sw,
                  shouldWrap: true,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          // Healthcare provider line:
          Card(
            elevation: 5,
            margin: const EdgeInsets.only(left: 8, right: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            color: Colors.white,
            child: VisitTapEditBox(
              visit: widget.visit,
              dataType: 'healthcareProvider',
              inputData: widget.visit!.healthcareProvider,
              defaultText: "Healthcare provider (e.g. Legacy Hospital)...",
              isEditingVisit: true,
              updateFunction: widget.updateVisitFunction,
              // boxDecoration: BoxDecoration(
              //     color: Colors.white,
              //     // border: Border.all(),
              //     borderRadius: BorderRadius.circular(8.0)),
              defaultTextStyle: Styles.articleBodySmallGreyed,
              // height: 32.0,
              width: .97.sw,
              shouldWrap: true,
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Expanded(
                child: getNotes(),
              ),
            ],
          )),
          PatienceBackButton(
            callback: () => Navigator.pop(context),
          ), // Use Expanded to take up remaining space on screen
        ],
      ),
    );
  }
}
