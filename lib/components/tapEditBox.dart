import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TapEditBox extends StatefulWidget {
  TapEditBox({Key key}) : super(key: key);

  @override
  _TapEditBoxState createState() => _TapEditBoxState();
}

class _TapEditBoxState extends State<TapEditBox> {
  TextEditingController _editingController;
  bool _isEditing = false;
  String inputData = 'haha';

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: inputData);
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
                inputData = newText;
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
                    text: inputData, style: TextStyle(color: Colors.black)),
                textAlign: TextAlign.center,
              )));
    }
  }
}
