import 'package:flutter/material.dart';
import 'package:hospital_stay_helper/config/styles.dart';

Padding buildPageDescriptionGradient(String description, List<Color> colors) {
  return Padding(
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 6,
                  offset: Offset(0, 3))
            ],
            gradient: LinearGradient(
              colors: colors,
              // begin: Alignment.topLeft,
              // end: Alignment.bottomRight,
              stops: [.1, .7],
            ),
            borderRadius: BorderRadius.circular(5.0)),
        child: Padding(
            child: Text(
              description,
              textAlign: TextAlign.left,
              style: Styles.articleBody,
            ),
            padding: EdgeInsets.fromLTRB(15, 11, 15, 11)),
        // child: Card(
        //   // color: Styles.lightPurpleTheme,
        //   child:
        // ),
      ),
      padding: EdgeInsets.fromLTRB(4, 12, 4, 12));
}

Padding buildPageDescriptionPink(String description) {
  return Padding(
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 6,
                  offset: Offset(0, 3))
            ],
            color: Styles.candyPinkTheme,
            borderRadius: BorderRadius.circular(5.0)),
        child: Padding(
            child: Text(
              description,
              textAlign: TextAlign.left,
              style: Styles.articleBody,
            ),
            padding: EdgeInsets.fromLTRB(15, 11, 15, 11)),
        // child: Card(
        //   // color: Styles.lightPurpleTheme,
        //   child:
        // ),
      ),
      padding: EdgeInsets.fromLTRB(4, 12, 4, 12));
}

Widget buildPageDescriptionColor(
    String title, String description, Color color) {
  return
      // Padding(
      //     padding: EdgeInsets.fromLTRB(4, 8, 4, 12),
      //     // child: Container(
      //     //   width: .7.sw,
      //     // child:
      //     child:
      Material(
    elevation: 7,
    child: ExpansionTile(
      key: PageStorageKey(title),
      backgroundColor: color,
      collapsedBackgroundColor: color,
      children: [
        Padding(
            child: Text(
              description,
              textAlign: TextAlign.left,
              style: Styles.articleBodySmall,
            ),
            padding: EdgeInsets.fromLTRB(15, 0, 15, 11)),
      ],
      title: Text(title, style: Styles.articleBodyBold),
      initiallyExpanded: false,
      // )
    ),
  );
  // Container(
  //   decoration: BoxDecoration(boxShadow: [
  //     BoxShadow(
  //         color: Colors.grey.withOpacity(0.5),
  //         spreadRadius: 4,
  //         blurRadius: 6,
  //         offset: Offset(0, 3))
  //   ], color: color, borderRadius: BorderRadius.circular(5.0)),
  //   child: Padding(
  //       child: Text(
  //         description,
  //         textAlign: TextAlign.left,
  //         style: Styles.articleBodySmall,
  //       ),
  //       padding: EdgeInsets.fromLTRB(15, 11, 15, 11)),
  //   // child: Card(
  //   //   // color: Styles.lightPurpleTheme,
  //   //   child:
  //   // ),
  // ),
  // padding: EdgeInsets.fromLTRB(4, 8, 4, 12));
}

// Widget testBuildPageDescriptionColor(
//     String description, Color color, bool visibility, Function toggleFunct) {
//   return Visibility(
//     visible: visibility,
//     replacement: Align(
//       alignment: Alignment.topRight,
//       child: ClipOval(
//         child: Material(
//           color: Colors.blue, // Button color
//           child: InkWell(
//             splashColor: Colors.red, // Splash color
//             onTap: toggleFunct,
//             child: SizedBox(
//               width: 40,
//               height: 40,
//               child: RotatedBox(
//                 quarterTurns: 3,
//                 child: Icon(
//                   Icons.chevron_left,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//     child: Stack(
//       alignment: Alignment.bottomRight,
//       children: [
//         Container(
//           margin: EdgeInsets.fromLTRB(4, 12, 4, 12),
//           decoration: BoxDecoration(boxShadow: [
//             BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 4,
//                 blurRadius: 6,
//                 offset: Offset(0, 3))
//           ], color: color, borderRadius: BorderRadius.circular(5.0)),
//           child: Padding(
//               child: Text(
//                 description,
//                 textAlign: TextAlign.left,
//                 style: Styles.articleBody,
//               ),
//               padding: EdgeInsets.fromLTRB(15, 11, 15, 11)),
//         ),
//         Align(
//           alignment: Alignment.topRight,
//           child: ClipOval(
//             child: Material(
//               color: Colors.blue, // Button color
//               child: InkWell(
//                 splashColor: Colors.red, // Splash color
//                 onTap: toggleFunct,
//                 child: SizedBox(
//                   width: 40,
//                   height: 40,
//                   child: RotatedBox(
//                     quarterTurns: 1,
//                     child: Icon(
//                       Icons.chevron_left,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         )
//       ],
//     ),
//   );
// }
