import 'package:flutter/material.dart';
import 'package:hospital_stay_helper/components/buttons.dart';
import 'package:hospital_stay_helper/components/guildeline_component/guildeline_widgets.dart';
import 'package:hospital_stay_helper/components/guildeline_component/situation_box.dart';

class BeforeStayPage extends StatelessWidget {
  BeforeStayPage(
      {
      // this.context,
      // this.rootCategoriesPage,
      Key? key})
      : super(key: key);

  // final BuildContext? context;
  // final RootCategoriesPage? rootCategoriesPage;
  final List<String> guidelinesTitles = [
    "Make a detailed visit-plan with your provider",
    "Create a file or one place to store all information related to your hospital visit",
    "Call your insurance provider whenever you have a question, and keep a record of each call",
    "Ask your insurance provider for a case-manager",
    "Ask your insurance provider about covered procedures and pre-approved healthcare workers",
    "Don’t rely on the online information from your insurance provider",
    "Ask for a detailed price estimate of all planned procedures",
    "Make a list of all hospital staff you plan to receive treatment from",
  ];
  final List<String> subGuidelinesText = [
    "If you know you have a hospital visit coming up, talk to your doctor or healthcare provider about your upcoming hospital visit. Discuss the guidelines 2, 3 and 4 with your provider and take detailed notes of any information you learn.",
    "The medical billing expert we spoke with when creating this app recommends that you create a place where you can keep any and all information related to your hospital stay. This can simply be a paper file folder or a box, or a digital folder on your computer for any digital notes, photos, emails, voice recordings, etc. you may have related to your visit.\n\nYou don’t need to be super organized, just make sure you keep any and all documents or information you receive in one place. For example, never throw away any letters that you receive related to your bill, even if you don’t understand them.",
    "Most of the questions related to your medical bills can be answered by your insurance provider, it is recommended to speak with them when planning your hospital visit.\n\nCall your insurance company while you are planning your visit and discuss the tests and/or procedures you plan to have. If the tests or procedures have already been ordered by your doctor, your insurance company should already have a copy of all the procedures/tests you will receive.\n\nIn order to keep a record of the conversations with your insurance company, ask for a reference number for each call you make, and the name of the person you speak with. This record will help you in future conversations.",
    "Your insurance company may be able to assign a specific person to your case. This person should be able to answer your questions about what is and is not covered and how much you will pay. You can simply say \“I’d really like to have one person manage my case.\”",
    "Call your insurance provider and ask them if there are hospital staff at the hospital you plan to stay at who are pre-approved (in-network: covered by your insurance). Also, ask which of the procedures/tests you plan to have are covered.\n\nOnce you know which healthcare providers are in-network, request to be seen by them at the hospital if possible.",
    "Ask your doctor or healthcare provider and your support person (a trusted friend or family member) to help you write a list of all the hospital staff (doctors, surgeons, assistants, etc.) who you believe will be treating you during your stay. Keep this list; it will help you if you receive a surprise bill later on.",
    "\“Studies have shown that more than half of provider directory information can be incorrect, including the phone number, address, whether the provider is taking patients and who’s considered in-network.\” It is strongly advised to always call your insurance provider before your visit and double check all of your questions with them.",
    "Ask the hospital administrators for a detailed price estimate of the procedure that you are planning to have. Knowing this, paired with the knowledge of how much your insurance will pay vs. how much you have to pay out-of-pocket, you should be able to get a good estimate of the costs of your upcoming visit/s.",
    "Ask your doctor or healthcare provider to help you write a list of all the hospital staff (doctors, surgeons, assistants, etc.) who you believe will be treating you during your stay. Keep this list; it will help you if you receive a surprise bill later on. ",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Styles.shadowWhite,
        // appBar: AppBar(
        //   toolbarHeight: 0.0,
        //   backgroundColor: Styles.modestPink,
        // ),
        body: GestureDetector(
      child: ListView(
        children: [
          SituationBox(
            text: "I'm preparing for a hospital visit",
            icon: Icons.laptop,
          ),
          GuidelineText(
            title: "1. " + guidelinesTitles[0],
            text: subGuidelinesText[0],
          ),
          GuidelineText(
            title: "2. " + guidelinesTitles[1],
            text: subGuidelinesText[1],
          ),
          GuidelineText(
            title: "3. " + guidelinesTitles[2],
            text: subGuidelinesText[2],
          ),
          GuidelineText(
            title: "4. " + guidelinesTitles[3],
            text: subGuidelinesText[3],
          ),
          GuidelineText(
            title: "5. " + guidelinesTitles[4],
            text: subGuidelinesText[4],
          ),
          GuidelineText(
            title: "6. " + guidelinesTitles[5],
            text: subGuidelinesText[5],
          ),
          GuidelineText(
            title: "7. " + guidelinesTitles[6],
            text: subGuidelinesText[6],
          ),
          GuidelineText(
            title: "8. " + guidelinesTitles[7],
            text: subGuidelinesText[7],
          ),
          PatienceBackButton(
            callback: () => Navigator.pop(context),
          ),
        ],
      ),
      onPanUpdate: (details) {
        if (details.delta.dx > 0) {
          //  User swiped left
          Navigator.pop(context);
        }
      },
    ));
  }
}
