import 'package:flutter/material.dart';

class TapEditBoxNumeric extends StatefulWidget {
  num? inputData;
  TextInputType keyboardType;
  String? defaultText;
  bool shouldWrap;
  final Function? updateFunction, parseFunction;
  final BoxDecoration? boxDecoration;
  final TextStyle textStyle;
  final TextAlign textAlign;
  double? height, width, margin, padding;
  int? noteIndex;

  TapEditBoxNumeric(
      {this.inputData,
      this.keyboardType = TextInputType.text,
      this.updateFunction,
      this.parseFunction,
      this.defaultText,
      this.boxDecoration,
      this.textStyle = const TextStyle(color: Colors.black, fontSize: 17),
      this.height,
      this.width,
      this.margin = 7.0,
      this.padding = 5.0,
      this.shouldWrap = false,
      this.textAlign = TextAlign.center,
      Key? key,
      this.noteIndex})
      : super(key: key);

  @override
  _TapEditBoxNumericState createState() => _TapEditBoxNumericState();
}

class _TapEditBoxNumericState extends State<TapEditBoxNumeric> {
  late TextEditingController _editingController;
  bool _isEditing = false;
  String? stringData;
  // String default_text;
  @override
  void initState() {
    super.initState();
    stringData = widget.inputData.toString();
    // if (widget.dataType == 'date') default_text = "Date created";
    // if (widget.dataType == 'patientName') default_text = "Patient name";

    _editingController = TextEditingController(text: stringData);
  }

  @override
  void dispose() {
    _editingController.dispose(); // Add to the dispose list
    super.dispose();
  }

  // Need to get input data to display even when typing

  @override
  Widget build(BuildContext context) {
    if (_isEditing) {
      return Container(
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.all(widget.margin!),
          decoration: widget.boxDecoration,
          height: widget.height,
          width: widget.width,
          child: TextFormField(
            keyboardType: widget.keyboardType,
            autofocus: true,
            initialValue: stringData,
            style: widget.textStyle,
            onFieldSubmitted: (newText) {
              setState(() {
                stringData = newText;
                widget.inputData = num.parse(stringData!);
                widget.updateFunction!(widget.inputData);
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
                  text: stringData == '' ? widget.defaultText : stringData,
                  style: widget.textStyle,
                ),
                textAlign: widget.textAlign,
                softWrap: widget.shouldWrap,
              )));
    }
  }
}
