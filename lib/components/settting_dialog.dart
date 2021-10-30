import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showSettingDialog(
    BuildContext context, VoidCallback yesAction, VoidCallback noAction) {
  if (Platform.isAndroid)
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            elevation: 10,
            title: Text("Set your profile at User Settings"),
            content: Image.asset(
              'assets/images/setup_settings_crop.png',
              width: .30.sw,
              height: .30.sw,
            ),
            actions: [
              TextButton(onPressed: noAction, child: Text("Later")),
              TextButton(onPressed: yesAction, child: Text("Okay")),
            ],
          );
        });
  if (Platform.isIOS)
    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text("Set your profile at User Settings"),
            content: Image.asset(
              'assets/images/setup_settings_crop.png',
              width: .30.sw,
              height: .30.sw,
            ),
            actions: [
              CupertinoDialogAction(onPressed: noAction, child: Text("Later")),
              CupertinoDialogAction(onPressed: yesAction, child: Text("Okay")),
            ],
          );
        });
}
