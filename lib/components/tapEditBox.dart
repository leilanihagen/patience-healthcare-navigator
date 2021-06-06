import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hospital_stay_helper/main.dart';

class TapEditBox extends StatelessWidget {
  final Function updateData;
  TapEditBox({this.updateData});

  @override
  Widget build(BuildContext context) {
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
          onChanged: (text) {
            updateData(text);
          },
        ));
  }
}
