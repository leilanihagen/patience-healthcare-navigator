import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';

String purpleTheme = "#66558E";
String lightPinkTheme = "#FDEBF1";
String darkPinkTheme = "#ED558C";
String blueTheme = "#54D0EB";
String darkGreenTheme = "#758C20";
String lightGreenTheme = "#A1BF36";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(App()));
}
