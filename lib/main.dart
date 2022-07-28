import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.openBox('mainController');
  await Hive.openBox('profile');
  await Hive.openBox('visitsTimeline');
  await Hive.openBox('checkHospitalPage');

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        // systemNavigationBarColor: Styles.blueTheme,
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent),
  );
  runApp(const App());
}
