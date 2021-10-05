import 'package:flutter/material.dart';
import 'package:hospital_stay_helper/class/class.dart';
import 'package:hospital_stay_helper/components/textIcon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListTop extends StatelessWidget {
  final VoidCallback? callback;
  final Top3 top3;
  const ListTop({this.callback, required this.top3, Key? key})
      : super(key: key);
  getDistanceColor(double distance) {
    if (distance < 10) return Colors.green[800];
    if (distance < 20) return Colors.yellow[800];
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 6,
            offset: Offset(0, 3))
      ]),
      padding: EdgeInsets.all(5),
      child: ListTile(
        onTap: callback,
        tileColor: Colors.white,
        title: Text(top3.name!),
        subtitle: Text(top3.street! + ', ' + top3.state!),
        trailing: Wrap(
          spacing: 5,
          children: [
            Text(
              "${top3.distance} mile",
              style: TextStyle(
                color: getDistanceColor(top3.distance),
              ),
            ),
            top3.er! ? ERIcon() : SizedBox(width: 40.h),
            top3.ur! ? URIcon() : SizedBox(width: 40.h),
          ],
        ),
      ),
    );
  }
}
