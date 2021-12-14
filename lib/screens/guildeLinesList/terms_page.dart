import 'package:flutter/material.dart';
import 'package:hospital_stay_helper/components/buttons.dart';
import 'package:hospital_stay_helper/components/guildeline_component/guildeline_widgets.dart';
import 'package:hospital_stay_helper/components/guildeline_component/situation_box.dart';

class TermsPage extends StatelessWidget {
  TermsPage({Key? key}) : super(key: key);

  // final BuildContext? context;
  // final RootCategoriesPage? rootCategoriesPage;
  final List<String> guidelinesTitles = [
    "Provider",
    "Deductible",
    "Copay (copayment)",
    "Coinsurance",
    // "Service",
    "Covered Service",
    "In-network provider",
    "Out-of-network provider",
    "Surprise Bill",
    "Provider Network",
  ];
  final List<String> subGuidelinesText = [
    "\“A healthcare provider is a person or company that provides a healthcare service to you. In other words, your healthcare provider takes care of you.\” \“Provider\” is a very broad term and can refer to your primary care doctor, a physician at an emergency room, the hospital itself, and even your pharmacy.",
    "The amount you pay for your healthcare services before your health insurer pays. Deductibles are based on your benefit period (typically a year at a time). \nExample: If your plan has a \$2,000 annual deductible, you will be expected to pay the first \$2,000 toward your healthcare services. After you reach \$2,000, your health insurer will cover the rest of the costs.",
    "A flat rate fee that you pay each time you utilize certain healthcare services that are covered by your insurance. “For example, if you hurt your back and go see your doctor, or you need a refill of your child's asthma medicine, the amount you pay for that visit or medicine is your copay.” Each time you use healthcare services with a copay, the copay covers a certain portion of their cost and the other portion is paid by your insurance company. Copays do not usually count as payments toward your deductible but check with your insurance plan to learn how this works with your plan.",
    "\“Coinsurance is your share of the costs of a health care service.\” \“You start paying coinsurance after you've paid your plan's deductible.\”\“How it works: You’ve paid \$1,500 in health care expenses and met your deductible. When you go to the doctor, instead of paying all costs, you and your plan share the cost. For example, your plan pays 70 percent. The 30 percent you pay is your coinsurance.\”",
    "\“A healthcare provider’s service or medical supplies covered by your health plan. Benefits will be given for these services based on your plan.\” This means that your insurance has agreed to pay part of the cost for these services.",
    "\“-a health care provider that has a contract with your health insurance plan to provide health care services to its plan members at a pre-negotiated rate. Because of this relationship, you pay a lower cost-sharing when you receive services from an in-network doctor.” It is advised that you receive care only from in-network providers whenever possible because this will greatly reduce the cost of healthcare for you as the patient/consumer.",
    "\“-a health care provider who does not have a contract with your health insurance plan. If you use an out-of-network provider, health care services could cost more since the provider doesn’t have a pre-negotiated rate with your health plan.\” Out of network bills can be extremely costly, and should be avoided whenever possible.",
    // number 8, no source (use non-hyperlink guidline):
    "A medical bill that a patient receives that is larger than expected or that will cause financial stress to the patient. More specifically, most “surprise bills” occur when a patient receives care from a provider that is out-of-network with their insurance or receives a type of treatment or test that is not a covered service under their insurance plan.",
    "\“Most health plans have provider networks. These networks are groups of providers that have agreed to provide services to the health plan’s members at a discounted rate and that have met the quality standards required by your insurer. Your health plan prefers that you use its in-network providers rather than using out-of-network providers.\”",
  ];

  final List<String> hyperlinkHintsText = [
    "Source (verywellhealth.com article)",
    "Source (medmutual.com article)",
    "Source (cigna.com article)",
    "Source (cigna.com article)",
    "Source (medmutual.com article)",
    "Source (insights.ibx.com article)",
    "Source (insights.ibx.com article)",
    "Source (verywellhealth.com article)",
  ];

  final List<String> hyperlinks = [
    "https://www.verywellhealth.com/what-is-a-provider-1738759",
    "https://www.medmutual.com/For-Individuals-and-Families/Health-Insurance-Education/Glossary-of-Terms.aspx",
    "https://www.cigna.com/individuals-families/understanding-insurance/copays-deductibles-coinsurance",
    "https://www.cigna.com/individuals-families/understanding-insurance/copays-deductibles-coinsurance",
    "https://www.medmutual.com/For-Individuals-and-Families/Health-Insurance-Education/Glossary-of-Terms.aspx",
    "https://insights.ibx.com/understanding-the-difference-between-in-network-and-out-of-network/",
    "https://insights.ibx.com/understanding-the-difference-between-in-network-and-out-of-network/",
    "https://www.verywellhealth.com/what-is-a-provider-1738759",
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        child: ListView(
          children: [
            SituationBox(
                text: "I want to learn healthcare terms and definitions",
                icon: Icons.menu_book_rounded),
            // renderGuidelineRichText(
            //     guidelinesTitles[0], subGuidelinesText[0], 1, 0),
            GuidelineHyperLinkText(
                title: "1. " + guidelinesTitles[0],
                text: subGuidelinesText[0],
                hyperLinkText: hyperlinkHintsText[0],
                hyperLink: hyperlinks[0]),
            GuidelineHyperLinkText(
                title: "2. " + guidelinesTitles[1],
                text: subGuidelinesText[1],
                hyperLinkText: hyperlinkHintsText[1],
                hyperLink: hyperlinks[1]),
            GuidelineHyperLinkText(
                title: "3. " + guidelinesTitles[2],
                text: subGuidelinesText[2],
                hyperLinkText: hyperlinkHintsText[2],
                hyperLink: hyperlinks[2]),
            GuidelineHyperLinkText(
                title: "4. " + guidelinesTitles[3],
                text: subGuidelinesText[3],
                hyperLinkText: hyperlinkHintsText[3],
                hyperLink: hyperlinks[3]),
            GuidelineHyperLinkText(
                title: "5. " + guidelinesTitles[4],
                text: subGuidelinesText[4],
                hyperLinkText: hyperlinkHintsText[4],
                hyperLink: hyperlinks[4]),
            GuidelineHyperLinkText(
                title: "6. " + guidelinesTitles[5],
                text: subGuidelinesText[5],
                hyperLinkText: hyperlinkHintsText[5],
                hyperLink: hyperlinks[5]),
            GuidelineHyperLinkText(
                title: "7. " + guidelinesTitles[6],
                text: subGuidelinesText[6],
                hyperLinkText: hyperlinkHintsText[6],
                hyperLink: hyperlinks[6]),
            GuidelineText(
                title: "8. " + guidelinesTitles[7], text: subGuidelinesText[7]),
            GuidelineHyperLinkText(
                title: "9. " + guidelinesTitles[8],
                text: subGuidelinesText[8],
                hyperLinkText: hyperlinkHintsText[7],
                hyperLink: hyperlinks[7]),
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
