import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hospital_stay_helper/class/visit.dart';

class TapEditBox extends StatefulWidget {
  Visit visit;
  String inputData, dataType;
  final Function updateFunction;
  TapEditBox(
      {Key key, this.visit, this.inputData, this.dataType, this.updateFunction})
      : super(key: key);

  @override
  _TapEditBoxState createState() => _TapEditBoxState();
}

class _TapEditBoxState extends State<TapEditBox> {
  TextEditingController _editingController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
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
          decoration: BoxDecoration(
              color: Colors.white,
              // border: Border.all(),
              borderRadius: BorderRadius.circular(8.0)),
          height: 32.0,
          width: 120.0,
          child: TextField(
            onSubmitted: (newText) {
              setState(() {
                widget.inputData = newText;
                widget.updateFunction(
                    widget.visit,
                    widget.dataType,
                    widget
                        .inputData); // TODO: Add editing visit/note flag and pass noteIndex
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
              height: 32.0,
              width: 120.0,
              child: RichText(
                text: TextSpan(
                    text: widget.inputData,
                    style: TextStyle(color: Colors.black)),
                textAlign: TextAlign.center,
              )));
    }
  }
}
