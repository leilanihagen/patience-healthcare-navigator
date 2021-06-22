import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final String purpleTheme = "#66558E";
  final String lightPinkTheme = "#FDEBF1";
  final String darkPinkTheme = "#ED558C";
  final String blueTheme = "#44B5CD";
  // final String darkGreenTheme = "#758C20";
  final String lightGreenTheme = "#A1BF36";

  Widget buildWalkthroughCard() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.all(10),
        height: 200,
        decoration: BoxDecoration(
            color: HexColor(lightGreenTheme),
            borderRadius: BorderRadius.circular(20.0))
        // gradient: LinearGradient(
        //     colors: [Colors.white12, HexColor(lightGreenTheme)])),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text("Welcome to Patience!"), buildWalkthroughCard()],
    );
  }
}
