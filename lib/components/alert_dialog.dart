import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

Future<bool> showConfirm(BuildContext context) async {
  bool? result;
  if (Platform.isAndroid)
    result = await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Confirm delete?"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text("Yes")),
            ],
          );
        });
  if (Platform.isIOS)
    result = await showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text("Confirm delete?"),
            actions: [
              CupertinoDialogAction(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text("Cancel")),
              CupertinoDialogAction(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text("Yes")),
            ],
          );
        });
  return result ?? false;
}
