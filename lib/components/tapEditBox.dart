import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hospital_stay_helper/class/visit.dart';

class TapEditBox extends StatefulWidget {
  Visit visit;
  String dataType, inputData, defaultText;
  bool isEditingVisit;
  final Function updateFunction;
  final BoxDecoration boxDecoration;
  double height, width;
  int noteIndex;

  TapEditBox(
      {this.visit,
      this.dataType,
      this.inputData,
      this.isEditingVisit,
      this.updateFunction,
      this.defaultText,
      this.boxDecoration,
      this.height,
      this.width,
      Key key,
      this.noteIndex})
      : super(key: key);

  @override
  _TapEditBoxState createState() => _TapEditBoxState();
}

class _TapEditBoxState extends State<TapEditBox> {
  TextEditingController _editingController;
  bool _isEditing = false;
  // String default_text;
  @override
  void initState() {
    super.initState();
    // if (widget.dataType == 'date') default_text = "Date created";
    // if (widget.dataType == 'patientName') default_text = "Patient name";

    _editingController = TextEditingController(text: widget.inputData);
  }

  @override
  void dispose() {
    _editingController.dispose(); // Add to the dispose list
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditing) {
      return Container(
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.all(7.0),
          decoration: widget.boxDecoration,
          height: widget.height,
          width: widget.width,
          child: TextField(
            onSubmitted: (newText) {
              setState(() {
                widget.inputData = newText;
                if (widget.isEditingVisit) {
                  widget.updateFunction(
                      widget.visit, widget.dataType, widget.inputData);
                } else {
                  widget.updateFunction(widget.visit, widget.noteIndex,
                      widget.dataType, widget.inputData);
                }
                // TODO: Add editing visit/note flag and pass noteIndex
                _isEditing = false;
              });
            },
          ));
    } else {
      return GestureDetector(
          onTap: () {
            setState(() {
              _isEditing = true;
            });
          },
          child: Container(
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(),
                  borderRadius: BorderRadius.circular(8.0)),
              height: widget.height,
              width: widget.width,
              child: RichText(
                text: TextSpan(
                    text: widget.inputData.isEmpty
                        ? widget.defaultText
                        : widget.inputData,
                    style: TextStyle(color: Colors.black)),
                textAlign: TextAlign.center,
              )));
    }
  }
}
