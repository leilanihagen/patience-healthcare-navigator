import 'package:flutter/material.dart';
import 'package:hospital_stay_helper/components/buttons.dart';
import 'package:hospital_stay_helper/components/guildeline_component/guildeline_widgets.dart';
import 'package:hospital_stay_helper/components/guildeline_component/situation_box.dart';

class AfterStayPage extends StatelessWidget {
  AfterStayPage({
    Key? key,
    // this.context,
    // this.rootCategoriesPage,
  });

  // final BuildContext? context;
  // final RootCategoriesPage? rootCategoriesPage;
  final List<String> guidelinesTitles = [
    "Do not pay any portion of your bill until disputing it",
    "Ask the hospital if they offer financial assistance/aid or charity care",
  ];
  final List<String> subGuidelinesText = [
    "If you have received a large bill, do not pay even a small part of it until you have disputed the bill first. You can dispute the bill directly with the hospital or the hospital's billing agency (depending on if your hospital uses one), with the collections agency, if your bill has been sent to collections, or both. You may be able to write a simple letter to stop collections agencies from contacting you.\n\nPlease read more disputing bills in the \"I've received a surprise medical bill\" and \"My medical bill/debt has been sent to collections\" categories.",
    "Many hospitals, including all non-profit hospitals, offer financial assistance to help you pay for your medical bills. Ask the hospital if they offer any of these programs to help you pay off your bill.",
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      // backgroundColor: Styles.shadowWhite,
      // appBar: AppBar(
      //   toolbarHeight: 0.0,
      //   backgroundColor: Styles.modestPink,
      // ),
      child: GestureDetector(
        child: ListView(
          children: [
            SituationBox(
              text: "I recently visited the hospital",
              icon: Icons.medical_services_rounded,
            ),
            GuidelineText(
              title: "1. " + guidelinesTitles[0],
              text: subGuidelinesText[0],
            ),
            GuidelineText(
              title: "2. " + guidelinesTitles[1],
              text: subGuidelinesText[1],
            ),
            PatienceBackButton(
              callback: () => Navigator.pop(context),
            )
          ],
        ),
        onPanUpdate: (details) {
          if (details.delta.dy > 0) {
            //  User swiped left
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
