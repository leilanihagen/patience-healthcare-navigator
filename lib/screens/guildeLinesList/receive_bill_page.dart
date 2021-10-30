import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hospital_stay_helper/components/buttons.dart';
import 'package:hospital_stay_helper/components/guildeline_component/guildeline_widgets.dart';
import 'package:hospital_stay_helper/components/guildeline_component/situation_box.dart';
import 'package:hospital_stay_helper/config/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ReceivedBillPage extends StatelessWidget {
  ReceivedBillPage({
    Key? key,
    // this.context,
    // this.rootCategoriesPage,
  });

  // final BuildContext? context;
  // final RootCategoriesPage? rootCategoriesPage;
  final List<String> guidelinesTitles = [
    "Don’t run from the bill",
    "Apply for financial aid through the hospital",
    "Ask about payment plans, pay small amounts toward your bill, then ask to negotiate",
    "Dispute the bill with the hospital",
  ];

  // final String titleText = "Write a letter to the hospital disputing the bill";
  final List<String> subGuidelinesText = [
    "When you receive an unjustly large bill, it is a common reaction to want to run from it, avoid talking to the hospital, and simply not pay. However, there are many things that can be done to dispute your bill, negotiate a lower price, receive financial assistance, and pay off your bill over a longer period of time.",
    "All hospitals who receive Medicaid funding are required to provide charity care and financial assistance programs. Apply for this financial aid, even if you don’t think you will qualify, because it shows the hospital that you are trying to find ways to pay and work with them.\n\nAsk for your account to be placed on hold while your application is being processed. This is common practice, but make sure you ask that this is done just in case.",
    "Ask the hospital if you can enroll in a payment plan. This will allow you to pay off your bill in small amounts over an extended period of time. If you do this and you try your best to pay small amounts toward your bill whenever you can, after a while you may be able to renegotiate the amount of your bill. Explain that you are concerned you will not be able to pay the current amount, and that a smaller amount would be more manageable for your situation.\n\nA medical billing expert we spoke with about this situation and assures patients that negotiating bills is common practice for hospitals, and some hospitals may be even more willing to give patients renegotiations at the end of the year, when they want to close billing accounts in preparation for the new year.",
    // "Many medical bills sent to patients are confusing and lack sufficient detail for the charges to be well-understood by the patient.\n\nHave a close friend or family member help you write an email (preferred, if possible) or letter to the hospital explaining that you will need more detailed information describing your charges and how they were calculated before you can pay. Try not to worry about sounding professional, just describe what you need from the hospital in simple language.\n\nElements to include in your letter:\n\n(a) Ask in your letter that the billing agency and/or hospital explain to you how each individual charge was determined.\n\n(b) Ask that they provide you with an itemized bill for each date of service they are charging you for.\n\n(c) Once you receive the itemized bill and an explanation of the hospitals charges, you will want to compare this information to the information in your insurance plan’s Explanation of Benefits form.\n\n(d) Ask that they show you evidence that they complied with federal and state pricing laws (in your state).\n\n(e) State that you will pay the correct amount according to your insurance plan’s Explanation of Benefits form after the hospital provides you with all requested information. You may state that it is your right as a consumer to have detailed knowledge about what exactly you are paying for.\n\n(f) Finally, state that you are disputing your bill and that you wish to have your account marked as disputed. State that if your bill is sent to a collections agency, you wish that the hospital/billing agency include a copy of all correspondence between yourself and the hospital, and that the hospital marks your file as disputed.",
  ];

  final List<String> hyperlinkHintsText = [
    "Source (YouTube Video by DerekVanSchaik)",
    "A template letter (brokenhealthcare.org article) (We recommend adding more from the above mentioned points.)",
  ];

  final List<String> hyperlinks = [
    "https://www.youtube.com/watch?v=fo3lvAS96a8&ab_channel=DerekVanSchaik",
    "https://brokenhealthcare.org/dispute-every-hospital-bill/",
  ];

  // final String introduction = '''
  // Write a letter to your hospital explaining that you will need more detailed information describing your charges and how they were calculated before you can pay. Try not to worry about sounding professional, just describe what you need from the hospital in simple language.
  // \nElements to include in your letter:
  // ''';
  // final List<String> subGuidelinesText = [
  //   '''
  // (a) Ask in your letter that the billing agency and/or hospital explain to you how each individual charge was determined. Ask for the hospital’s entire price list, which you are entitled to under 42 U.S.C.A. § 300gg-18(e) (you should state this).
  // ''',
  //   '''
  // (b) Ask that they provide you with a copy of your medical treatment record in order to explain each charge.
  // ''',
  //   '''
  // (c) If there are any Adjustments or Discounts stated on your bill, ask them to “provide numerical detail” on how these adjustments or discounts were arrived at including price negotiations with your insurance company.”
  // ''',
  //   '''
  // (d) Ask that they show you evidence that they complied with federal and state pricing laws (in your state).
  // ''',
  //   '''
  // (e) State that you will pay the requested amount after the hospital provides you with the requested information.
  // ''',
  //   '''
  // (f) Finally, state that you are disputing your bill and that you wish to have the record of your bill marked as disputed. State that if your bill is sent to a collections agency, you wish that the hospital/billing agency include a copy of all correspondence between yourself and the hospital, and that the hospital marks your file as disputed.
  // '''
  // ];

  @override
  Widget build(BuildContext context) {
    Widget guideline4Text = RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyText1,
        children: [
          TextSpan(
              text:
                  "Many medical bills sent to patients are confusing and lack sufficient detail for the charges to be well-understood by the patient.\n\nHave a close friend or family member help you write an email (preferred, if possible) or letter to the hospital explaining that you will need more detailed information describing your charges and how they were calculated before you can pay. Try not to worry about sounding professional, just describe what you need from the hospital in simple language.\n\nElements to include in your letter:\n\n(a) Ask in your letter that the billing agency and/or hospital explain to you how each individual charge was determined.\n\n(b) Ask that they provide you with an itemized bill for each date of service they are charging you for.\n\n(c) Once you receive the itemized bill and an explanation of the hospitals charges, you will want to compare this information to the information in your insurance plan’s Explanation of Benefits form.\n\n(d) Ask that they show you evidence that they complied with federal and state pricing laws (in your state).\n\n(e) State that you will pay the correct amount according to your insurance plan’s Explanation of Benefits form after the hospital provides you with all requested information. You may state that it is your right as a consumer to have detailed knowledge about what exactly you are paying for.\n\n(f) Finally, state that you are disputing your bill and that you wish to have your account marked as disputed. State that if your bill is sent to a collections agency, you wish that the hospital/billing agency include a copy of all correspondence between yourself and the hospital, and that the hospital marks your file as disputed." +
                      "\n"),
          TextSpan(
            text: "Source (YouTube Video by DerekVanSchaik)\n\n",
            style: Styles.hyperlink,
            recognizer: TapGestureRecognizer()
              ..onTap = () => launch(
                  "https://www.youtube.com/watch?v=fo3lvAS96a8&ab_channel=DerekVanSchaik"),
          ),
          TextSpan(
            text:
                "A template letter (brokenhealthcare.org article) (We recommend adding more from the above mentioned points.)",
            style: Styles.hyperlink,
            recognizer: TapGestureRecognizer()
              ..onTap = () => launch(
                  "https://brokenhealthcare.org/dispute-every-hospital-bill/"),
          )
        ],
      ),
    );
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
            text: "I've received a surprise medical bill",
            icon: Icons.attach_money_rounded,
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
          GuidelineCustomWidget(
            title: "4. " + guidelinesTitles[3],
            child: guideline4Text,
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
    ));
  }
}
