import 'package:flutter/material.dart';
import 'package:hospital_stay_helper/components/buttons.dart';
import 'package:hospital_stay_helper/components/guildeline_component/guildeline_widgets.dart';
import 'package:hospital_stay_helper/components/guildeline_component/situation_box.dart';

class DuringStayPage extends StatelessWidget {
  DuringStayPage({Key? key}) : super(key: key);
  final List<String> guidelinesTitles = [
    "Ask if you will be treated by in-network physicians/providers",
    "Call your insurance provider to ask about costs and what is covered",
    "Record the names of each hospital staff member who treats you during your visit",
    "Record everything that happens and everything you learn during your visit",
    "Do not pay any portion of a bill if you do not fully understand the charges",
    "Never \“pay out your deductible\” if you are not told the exact amount of your bill",
    "Don’t rely on all information that the hospitals receptionists or billing department give you",
  ];
  final List<String> subGuidelinesText = [
    "When you arrive to check-in for your appointment, ask the receptionist to double check that all of the providers you will be seeing during your visit are in-network with your insurance.\n\nEspecially if you will be treated by anesthesiologists or radiologists, which are very commonly contracted by the hospital and potentially out-of-network.",
    "The best thing to do when you want to find out what is covered under your insurance and how much procedures/services cost is to call your insurance company. They are often the only ones who will be able to tell you exactly what is covered and the amount of the final bill you will likely have to pay.",
    "Have a trusted friend or family member (support person) help you keep a record of the names and job title of every healthcare worker who takes care of you during your visit. You and your support person can use a simple pen and paper, a notes app on your phone, voice recordings and/or pictures of documents to help you keep track of your healthcare providers.",
    "Have a close friend or family member help you take chronological notes of everything that happens during your visit, such as “Seen by nurse Susan Smith at 11:10am.” Also, note any information that you learn from your healthcare providers during your hospital stay, such as if a certain doctor is in-network or out-of network, medical advice given to you by a nurse or a doctor, over the counter treatments you may try, etc. This will not only help you avoid surprise bills, it will also help you manage your health.",
    "If you are asked to pay any amount for your treatment while you are at the hospital, ask to see an itemized bill describing each of your charges in detail. Never pay any amount until you fully understand each charge.\n\nThe best option is to wait until after you leave the hospital before you pay any amount toward your bill or bills. This is because you may be able to negotiate or dispute the bill by writing a simple letter before you pay. See the “I recently visited the hospital” and “I have received a surprise medical bill” sections to learn how you can dispute or negotiate bills before paying.",
    "Many hospitals have adopted the practice of asking patients to pay out the full amount of their insurance plan’s deductible as payment toward a bill before the patient receives care or before the patient has access to the final bill. You should never agree to pay out your deductible until your insurance company tells you how much your bill will be and/or the hospital gives you your fully itemized bill.\n\nTo learn more about this practice used by hospitals, please read the source article below.",
    "Unfortunately, many hospital receptionists or billing departments will not know specific policies of your insurance provider, or even how much various services/procedures will cost.\n\nPlease see guideline number 2 in this section.",
  ];

  final List<String> hyperlinkHintsText = [
    "Source (verywellhealth.com article)",
  ];

  final List<String> hyperlinks = [
    "https://www.verywellhealth.com/paying-deductible-before-receiving-care-4159403",
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
              text: "I'm at the hospital now",
              icon: Icons.sick_rounded,
            ),
            GuidelineText(
              title: "1. " + guidelinesTitles[0],
              text: subGuidelinesText[0],
            ),
            GuidelineText(
              title: "1. " + guidelinesTitles[1],
              text: subGuidelinesText[1],
            ),
            GuidelineText(
              title: "1. " + guidelinesTitles[2],
              text: subGuidelinesText[2],
            ),
            GuidelineText(
              title: "1. " + guidelinesTitles[3],
              text: subGuidelinesText[3],
            ),
            GuidelineText(
              title: "1. " + guidelinesTitles[4],
              text: subGuidelinesText[4],
            ),
            GuidelineHyperLinkText(
              title: "1. " + guidelinesTitles[5],
              text: subGuidelinesText[5],
              hyperLinkText: hyperlinkHintsText[0],
              hyperLink: hyperlinks[0],
            ),
            GuidelineText(
              title: "1. " + guidelinesTitles[6],
              text: subGuidelinesText[6],
            ),
            PatienceBackButton(
              callback: () => Navigator.pop(context),
            ),
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
