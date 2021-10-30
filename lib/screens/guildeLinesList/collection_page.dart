import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hospital_stay_helper/components/buttons.dart';
import 'package:hospital_stay_helper/components/guildeline_component/situation_box.dart';
import 'package:hospital_stay_helper/config/styles.dart';
import 'package:hospital_stay_helper/screens/guidelines_page.dart';
import 'package:hospital_stay_helper/components/guildeline_component/guildeline_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class CollectionsPage extends StatelessWidget {
  CollectionsPage({Key? key
      // this.context,
      // this.rootCategoriesPage,
      })
      : super(key: key);

  // final BuildContext? context;
  // final RootCategoriesPage? rootCategoriesPage;
  final List<String> guidelinesTitles = [
    "Remember that you have time",
    "You may want to ask for the debt to be sent back to the hospital’s billing agency",
    "Send a debt validation letter",
    "Ask to set up a payment plan and try to negotiate the amount of the bill",
    "Pay off other debt before your medical debt",
    "Don’t trade medical debt for other types of debt, or pay off medical bills with a credit card",
  ];
  final List<String> subGuidelinesText = [
    "Remember that most credit reporting agencies wait 180 days from when you are notified of a bill being sent to collections before the debt shows up on your credit report. You can use this time to make a plan for how to handle the debt.",
    "Sometimes hospitals send medical bills to collections agencies prematurely. If your bill was sent to collections before you got a chance to work out a payment plan with the hospital’s billing agency, ask the hospital if they can send the bill back so that you can settle it with them directly.",
    // ("You have the right to send a debt validation letter/email to the collection agency under the FDCPA asking them to provide you with evidence that the debt you are being asked to pay is in fact yours." +
    //     "\n\nIn your letter/email, simply state that you will need to validate the debt before you can pay, and ask for documentation bearing your signature and dates of services you are being billed for. Either send the letter via certified mail or via email, so that you can record the date when the agency receives it." +
    //     "\n\nWhat you will do next depends on how the agency responds." +
    //     "\n\n(a) They do not respond within 30 days of receiving your request. If they do not respond, you can file a complaint with the Consumer Financial Protection Bureau here: https://www.consumerfinance.gov/complaint/getting-started/ After filing your complaint, send a Failure to Validate letter/email to the collection agency explaining that they have violated your rights as a consumer to have your debt violated, and that you have the right to sue them for damages to your credit score if the debt is not validated, or if the unvalidated debt is not removed from your credit report. Here is a template Failure to Validate letter: https://038b81d3-e365-410b-aae4-6abfa16bcab5.filesusr.com/ugd/ecc7c0_0178390f990542608eec0c82640cb513.pdf" +
    //     "\n\n(b) They send you a bill. If they do not send you the explanation of charges and proof that the debt belongs to you, you can also report them to the CFPB and send a Failure to Validate email/letter, because they did not provide sufficient documentation to validate the debt. If they respond within 30 days of receiving your request, do not report them to CFPB yet, but inform them that if they do not send you evidence to validate the debt, you will report them. See (a) and the source blog and video linked below." +
    //     "\n\n (c) They send you documentation containing your medical records, (information about procedures you received, doctors you were seen by, etc.). If they do this, immediately file a complaint with the Consumer Financial Protection Bureau for violating your rights under HIPAA. You never signed any agreement authorizing them to access your medical records, so if they obtain this information, they have violated your privacy rights under HIPAA. At this point, you have the option to sue them if you wish, but at the very least, they must remove the debt and cease collection of the debt if they have violated your HIPAA rights. Ask the collections agency to delete your private medical information immediately and to cease all collection activities." +
    //     "\n\n Source (Achieving Credit Excellence blog):\n https://www.achievingcreditexcellence.com/freebies\nhttps://www.youtube.com/watch?v=3xVGZ4QOCmk&ab_channel=LifeWithMC"),
    "After you have disputed your bill, if you were not able to get the debt removed, set up a payment plan with the collection agency so that you can pay small amounts toward your bill over time. After you have paid a bit of the bill off, you will be on good terms with the agency, and you should ask have your debt lowered/negotiated to an amount that you can afford.",
    "It may seem counterintuitive, but AARP recommends that you prioritize paying off other types of debt, such as car loans, credit card bills etc. before paying off your medical debt. This is because medical debt is less damaging to your credit score than other types of debt.",
    "The AARP warns patients not to trade medical debt for other types of debt; i.e. do not take out a loan to pay off your debt, or pay off your medical bills with a credit card. This is because medical debt typically does not have late fees or interest associated with it, while other forms of debt do. Medical debt also takes longer to appear on your credit report than other forms of debt, giving you more time to take care of it.",
  ];

  final List<String> hyperlinkHintsText = [
    "Source (aarp.org article)",
  ];

  final List<String> hyperlinks = [
    // Guidelines 1,2,5,6 are all accessing the same article:
    "https://www.aarp.org/money/credit-loans-debt/info-2019/medical-bills-affect-credit-score.html",
  ];

  // final Widget guideline3Text =
  //     Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //   Text(
  //     ("You have the right to send a debt validation letter/email to the collection agency under the FDCPA asking them to provide you with evidence that the debt you are being asked to pay is in fact yours." +
  //         "\n\nIn your letter/email, simply state that you will need to validate the debt before you can pay, and ask for documentation bearing your signature and dates of services you are being billed for. Either send the letter via certified mail or via email, so that you can record the date when the agency receives it." +
  //         "\n\nWhat you will do next depends on how the agency responds." +
  //         "\n\n(a) They do not respond within 30 days of receiving your request. If they do not respond, you can file a complaint with the Consumer Financial Protection Bureau "),
  //     style: Styles.articleBody.copyWith(color: Colors.black),
  //   ),
  //   InkWell(
  //       child: Text(
  //         "here (consumerfinance.gov complaint submission).\n\n",
  //         style: Styles.hyperlink,
  //       ),
  //       onTap: () => launch(
  //           "https://www.consumerfinance.gov/complaint/getting-started/")),
  //   Text(
  //     "After filing your complaint, send a Failure to Validate letter/email to the collection agency explaining that they have violated your rights as a consumer to have your debt violated, and that you have the right to sue them for damages to your credit score if the debt is not validated, or if the unvalidated debt is not removed from your credit report.",
  //     style: Styles.articleBody.copyWith(color: Colors.black),
  //   ),
  //   InkWell(
  //       child: Text(
  //         "\n\nHere is a template Failure to Validate letter (from the achievingcreditexcellence.com blog).",
  //         style: Styles.hyperlink,
  //       ),
  //       onTap: () =>
  //           launch("https://www.achievingcreditexcellence.com/freebies")),
  //   Text(
  //     "\n\n(b) They send you a bill. If they do not send you the explanation of charges and proof that the debt belongs to you, you can also report them to the CFPB and send a Failure to Validate email/letter, because they did not provide sufficient documentation to validate the debt. If they respond within 30 days of receiving your request, do not report them to CFPB yet, but inform them that if they do not send you evidence to validate the debt, you will report them. See (a) and the source blog and video linked below." +
  //         "\n\n (c) They send you documentation containing your medical records, (information about procedures you received, doctors you were seen by, etc.). If they do this, immediately file a complaint with the Consumer Financial Protection Bureau for violating your rights under HIPAA. You never signed any agreement authorizing them to access your medical records, so if they obtain this information, they have violated your privacy rights under HIPAA. At this point, you have the option to sue them if you wish, but at the very least, they must remove the debt and cease collection of the debt if they have violated your HIPAA rights. Ask the collections agency to delete your private medical information immediately and to cease all collection activities.",
  //     style: Styles.articleBody.copyWith(color: Colors.black),
  //   ),
  //   InkWell(
  //       child: Text(
  //         "\n\nSource (from the achievingcreditexcellence.com blog).",
  //         style: Styles.hyperlink,
  //       ),
  //       onTap: () =>
  //           launch("https://www.achievingcreditexcellence.com/freebies")),
  //   InkWell(
  //       child: Text(
  //         "\n\nSource (YouTube Video explaining how to dispute the debt).",
  //         style: Styles.hyperlink,
  //       ),
  //       onTap: () => launch(
  //           "https://www.youtube.com/watch?v=3xVGZ4QOCmk&ab_channel=LifeWithMC")),
  // ]);

  @override
  Widget build(BuildContext context) {
    Widget guideline3Text = RichText(
      text: TextSpan(style: Theme.of(context).textTheme.bodyText1, children: [
        TextSpan(
          text: ("You have the right to send a debt validation letter/email to the collection agency under the FDCPA asking them to provide you with evidence that the debt you are being asked to pay is in fact yours." +
              "\n\nIn your letter/email, simply state that you will need to validate the debt before you can pay, and ask for documentation bearing your signature and dates of services you are being billed for. Either send the letter via certified mail or via email, so that you can record the date when the agency receives it." +
              "\n\nWhat you will do next depends on how the agency responds." +
              "\n\n(a) They do not respond within 30 days of receiving your request. If they do not respond, you can file a complaint with the Consumer Financial Protection Bureau "),
        ),
        TextSpan(
          text: "here (consumerfinance.gov complaint submission).\n\n",
          style: Styles.hyperlink,
          recognizer: TapGestureRecognizer()
            ..onTap = () => launch(
                "https://www.consumerfinance.gov/complaint/getting-started/"),
        ),
        TextSpan(
          text:
              "After filing your complaint, send a Failure to Validate letter/email to the collection agency explaining that they have violated your rights as a consumer to have your debt violated, and that you have the right to sue them for damages to your credit score if the debt is not validated, or if the unvalidated debt is not removed from your credit report.",
        ),
        TextSpan(
          text:
              "\n\nHere is a template Failure to Validate letter (from the achievingcreditexcellence.com blog).",
          style: Styles.hyperlink,
          recognizer: TapGestureRecognizer()
            ..onTap = () =>
                launch("https://www.achievingcreditexcellence.com/freebies"),
        ),
        TextSpan(
          text: "\n\n(b) They send you a bill. If they do not send you the explanation of charges and proof that the debt belongs to you, you can also report them to the CFPB and send a Failure to Validate email/letter, because they did not provide sufficient documentation to validate the debt. If they respond within 30 days of receiving your request, do not report them to CFPB yet, but inform them that if they do not send you evidence to validate the debt, you will report them. See (a) and the source blog and video linked below." +
              "\n\n (c) They send you documentation containing your medical records, (information about procedures you received, doctors you were seen by, etc.). If they do this, immediately file a complaint with the Consumer Financial Protection Bureau for violating your rights under HIPAA. You never signed any agreement authorizing them to access your medical records, so if they obtain this information, they have violated your privacy rights under HIPAA. At this point, you have the option to sue them if you wish, but at the very least, they must remove the debt and cease collection of the debt if they have violated your HIPAA rights. Ask the collections agency to delete your private medical information immediately and to cease all collection activities.",
        ),
        TextSpan(
          text: "\n\nSource (from the achievingcreditexcellence.com blog).",
          style: Styles.hyperlink,
          recognizer: TapGestureRecognizer()
            ..onTap = () =>
                launch("https://www.achievingcreditexcellence.com/freebies"),
        ),
        TextSpan(
          text:
              "\n\nSource (YouTube Video explaining how to dispute the debt).",
          style: Styles.hyperlink,
          recognizer: TapGestureRecognizer()
            ..onTap = () => launch(
                "https://www.youtube.com/watch?v=3xVGZ4QOCmk&ab_channel=LifeWithMC"),
        )
      ]),
    );
    return Scaffold(
        body: GestureDetector(
      child: ListView(
        children: [
          SituationBox(
              text: "My medical bill/debt has been sent to collections",
              icon: Icons.priority_high_rounded),
          GuidelineHyperLinkText(
            title: "1. " + guidelinesTitles[0],
            text: subGuidelinesText[0],
            hyperLinkText: hyperlinkHintsText[0],
            hyperLink: hyperlinks[0],
          ),
          GuidelineHyperLinkText(
            title: "2. " + guidelinesTitles[1],
            text: subGuidelinesText[1],
            hyperLinkText: hyperlinkHintsText[0],
            hyperLink: hyperlinks[0],
          ),
          GuidelineCustomWidget(
            title: "3. " + guidelinesTitles[2],
            child: guideline3Text,
          ),
          GuidelineText(
            title: "4. " + guidelinesTitles[3],
            text: subGuidelinesText[2],
          ),
          GuidelineHyperLinkText(
            title: "5. " + guidelinesTitles[4],
            text: subGuidelinesText[3],
            hyperLinkText: hyperlinkHintsText[0],
            hyperLink: hyperlinks[0],
          ),
          GuidelineHyperLinkText(
              title: "6. " + guidelinesTitles[5],
              text: subGuidelinesText[4],
              hyperLinkText: hyperlinkHintsText[0],
              hyperLink: hyperlinks[0]),
          // renderGuideline(guidelinesTitles[3], subGuidelinesText[3], 4, 0),
          // renderGuideline(guidelinesTitles[4], subGuidelinesText[4], 5, 0),
          // renderGuideline(guidelinesTitles[5], subGuidelinesText[5], 6, 0),
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
