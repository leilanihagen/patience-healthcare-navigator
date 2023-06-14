import 'package:flutter/material.dart';

class ERIcon extends StatelessWidget {
  const ERIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Emergency services available',
      child: Container(
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(4.0),
          ),
          height: 35.0,
          width: 35.0,
          child: Center(
            child: Text(
              "E",
              style: Theme.of(context).primaryTextTheme.headline6,
            ),
          )),
    );
  }
}

class URIcon extends StatelessWidget {
  const URIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Urgent-care services available',
      child: Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(4.0),
          ),
          height: 35.0,
          width: 35.0,
          child: Center(
            child: Text(
              "U",
              style: Theme.of(context).primaryTextTheme.headline6,
            ),
          )),
    );
  }
}
