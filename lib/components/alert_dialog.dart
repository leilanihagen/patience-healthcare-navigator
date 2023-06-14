import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

Future<bool> showConfirm(BuildContext context) async {
  bool? result;
  if (Platform.isAndroid) {
    result = await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Confirm delete?"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: const Text("Yes")),
            ],
          );
        });
  }
  if (Platform.isIOS) {
    result = await showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (ctx) {
          return CupertinoAlertDialog(
            title: const Text("Confirm delete?"),
            actions: [
              CupertinoDialogAction(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text("Cancel")),
              CupertinoDialogAction(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: const Text("Yes")),
            ],
          );
        });
  }
  return result ?? false;
}
