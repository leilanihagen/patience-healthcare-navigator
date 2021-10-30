import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:hospital_stay_helper/components/buttons.dart';
import 'package:hospital_stay_helper/components/page_description.dart';
import 'package:hospital_stay_helper/config/styles.dart';
// import 'package:hospital_stay_helper/localizations/language_constants.dart';
// import 'package:hospital_stay_helper/main.dart';
import 'package:hospital_stay_helper/plugins/firebase_analytics.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:expandable/expandable.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:video_player/video_player.dart';
// import 'package:hexcolor/hexcolor.dart';

// Src: https://medium.com/flutter-community/everything-you-need-to-know-about-flutter-page-route-transition-9ef5c1b32823
// Not using yet:
// class SlideRightRoute extends PageRouteBuilder {
//   final Widget page;
//   SlideRightRoute({this.page})
//       : super(
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               page,
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) =>
//               SlideTransition(
//             position: Tween<Offset>(
//               begin: const Offset(-1, 0),
//               end: Offset.zero,
//             ).animate(animation),
//             child: child,
//           ),
//         );
// }

RichText renderClickableLinkPassage(String text, String urlText, String url) {
  return RichText(
      text: TextSpan(children: [
    TextSpan(text: text, style: TextStyle(color: Colors.black)),
    TextSpan(
        text: urlText,
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          })
  ]));
}

class CustomPageRouteBuilder<T> extends PageRoute<T> {
  final RoutePageBuilder? pageBuilder;
  final PageTransitionsBuilder matchingBuilder =
      const FadeUpwardsPageTransitionsBuilder(); // Default Android/Linux/Windows
  // final PageTransitionsBuilder matchingBuilder = const CupertinoPageTransitionsBuilder(); // Default iOS/macOS (to get the swipe right to go back gesture)

  CustomPageRouteBuilder({this.pageBuilder});

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return pageBuilder!(context, animation, secondaryAnimation);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(
      milliseconds:
          900); // Can give custom Duration, unlike in MaterialPageRoute

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return matchingBuilder.buildTransitions<T>(
        this, context, animation, secondaryAnimation, child);
  }
}

Widget renderClickableSituationCard(
    BuildContext context, pageBuilder, String situation, Icon icon) {
  return GestureDetector(
    onTap: () {
      observer.analytics
          .logEvent(name: 'guideLine', parameters: {'situation': situation});
      Navigator.push(
        context,
        CustomPageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                pageBuilder),
      );
    },
    child: renderSituationBox(situation, icon, 0.0),
  );
}

class _CustomRectTween extends RectTween {
  _CustomRectTween({Rect? begin, Rect? end}) : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    t = Curves.easeOut.transform(t);
    double animatedLeft = begin!.left + t * (end!.left - begin!.left);
    double animatedTop = begin!.top + t * (end!.top - begin!.top);
    double animatedRight = begin!.right + t * (end!.right - begin!.right);
    double animatedBottom = begin!.bottom + t * (end!.bottom - begin!.bottom);

    return Rect.fromLTRB(
        animatedLeft, animatedTop, animatedRight, animatedBottom);
  }
}

Widget renderSituationBox(String text, Icon icon,
    [double backButtonOpacity = 1]) {
  return Hero(
    tag: text,
    createRectTween: (begin, end) => _CustomRectTween(begin: begin, end: end),
    flightShuttleBuilder: (flightContext, animation, flightDirection,
        fromHeroContext, toHeroContext) {
      animation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeOut);

      return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return _SituationBoxTile(
            icon: icon,
            text: text,
            opacity: animation.value,
          );
        },
      );
    },
    child: _SituationBoxTile(
      icon: icon,
      text: text,
      opacity: backButtonOpacity,
    ),
  );
}

class _SituationBoxTile extends StatelessWidget {
  final Icon icon;
  final String text;
  final double opacity;

  const _SituationBoxTile({
    required this.icon,
    required this.text,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    double animProgress = 1 - opacity;

    return
        // Material(
        //   color: Colors.transparent,
        //   child:

        Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 15.0 * animProgress, vertical: 8 * animProgress),
      child: Material(
        elevation: 10,
        child: Container(
          // margin: EdgeInsets.symmetric(
          //     horizontal: 15.0 * animProgress, vertical: 8 * animProgress),
          decoration: BoxDecoration(
              color: Styles.modestPink,
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.5 * animProgress),
              //     spreadRadius: 4,
              //     blurRadius: 6,
              //     offset: Offset(0, 3),
              //   )
              // ],
              borderRadius: BorderRadius.circular(5.0 * animProgress)),
          child: Row(
            children: [
              Container(
                width: opacity * max(24.0, Material.defaultSplashRadius),
                child: Opacity(
                  opacity: opacity,
                  child: IconButton(
                    iconSize: 24.0,
                    splashRadius: Material.defaultSplashRadius,
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  leading: icon,
                  title: Text(
                    text,
                    style: Styles.guidelineCard,
                  ),
                ),
              ),
            ],
          ),
          // ),
        ),
      ),
    );
  }
}

Widget renderGuideline(
    String title, String text, int guidelineNum, int linesShownCollapsed) {
  return Container(
    color: Colors.white,
    child: Padding(
        child: ExpandablePanel(
          // theme: ThemeData(backgroundColor: Colors.white),
          header: Text(
            "$guidelineNum. " + title,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          collapsed: (linesShownCollapsed == 0)
              ? SizedBox.shrink()
              : Padding(
                  child: Text(
                    text,
                    style: Styles.articleBody,
                    softWrap: true,
                    maxLines: linesShownCollapsed,
                    overflow: TextOverflow.ellipsis,
                  ),
                  padding: EdgeInsets.fromLTRB(4, 12, 4, 4)),
          expanded: Padding(
              child: Text(
                text,
                style: Styles.articleBody.copyWith(color: Colors.black),
                softWrap: true,
              ),
              padding: EdgeInsets.fromLTRB(4, 12, 4, 4)),
        ),
        padding: EdgeInsets.fromLTRB(8, 15, 8, 15)),
  );
}

Widget renderGuidelineHyperlink(String title, String text, String hyperlinkText,
    String hyperlink, int guidelineNum, int linesShownCollapsed) {
  return Container(
    color: Colors.white,
    child: Padding(
        child: ExpandablePanel(
          // theme: ThemeData(backgroundColor: Colors.white),
          header: Text(
            "$guidelineNum. " + title,
            style: Styles.headerGuildline.copyWith(color: Colors.black),
          ),
          collapsed: (linesShownCollapsed == 0)
              ? SizedBox.shrink()
              : Padding(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (text + "\n"),
                          style:
                              Styles.articleBody.copyWith(color: Colors.black),
                        ),
                        InkWell(
                            child: Text(
                              hyperlinkText,
                              style: Styles.hyperlink,
                            ),
                            onTap: () => launch(hyperlink))
                      ]),
                  padding: EdgeInsets.fromLTRB(4, 12, 4, 4),
                ),
          expanded: Padding(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (text + "\n"),
                      style: Styles.articleBody.copyWith(color: Colors.black),
                    ),
                    InkWell(
                        child: Text(
                          hyperlinkText,
                          style: Styles.hyperlink,
                        ),
                        onTap: () => launch(hyperlink))
                  ]),
              padding: EdgeInsets.fromLTRB(4, 12, 4, 4)),
        ),
        padding: EdgeInsets.fromLTRB(8, 15, 8, 15)),
  );
}

Widget renderGuidelineCustomWidgetText(
    String title, Widget text, int guidelineNum, int linesShownCollapsed) {
  return Container(
    color: Colors.white,
    child: Padding(
        child: ExpandablePanel(
          // theme: ThemeData(backgroundColor: Colors.white),
          header: Text(
            "$guidelineNum. " + title,
            style: Styles.headerGuildline.copyWith(color: Colors.black),
          ),
          collapsed: (linesShownCollapsed == 0)
              ? SizedBox.shrink()
              : Padding(
                  child: text,
                  padding: EdgeInsets.fromLTRB(4, 12, 4, 4),
                ),
          expanded:
              Padding(child: text, padding: EdgeInsets.fromLTRB(4, 12, 4, 4)),
        ),
        padding: EdgeInsets.fromLTRB(8, 15, 8, 15)),
  );
}

class RootCategoriesPage extends StatelessWidget {
  RootCategoriesPage({this.context, this.beforeStayPage});

  final BuildContext? context;
  final BeforeStayPage? beforeStayPage;
  final Color icons = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Padding(
              //   child: Text(
              //     "Guidelines",
              //     textAlign: TextAlign.left,
              //     style: TextStyle(
              //         fontSize: 30,
              //         fontWeight: FontWeight.w800,
              //         color: Colors.white),
              //   ),
              //   padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              // ),
              buildPageDescriptionColor(
                "How to use Guidelines",
                "Learn things you can do before, during and after your hospital visit to help avoid surprise medical bills, and what to do if you recieve one.\n\nStart by choosing a category below that best fits your situation.",
                Theme.of(context).scaffoldBackgroundColor,
              ),
              //renderClickableSituationCard("I'm preparing for a hospital visit"),
              renderClickableSituationCard(
                  context,
                  TermsPage(),
                  "I want to learn healthcare terms and definitions",
                  Icon(Icons.menu_book_rounded, color: icons, size: 33)),
              renderClickableSituationCard(
                  context,
                  BeforeStayPage(),
                  "I'm preparing for a hospital visit",
                  Icon(Icons.laptop, color: icons, size: 33)),
              renderClickableSituationCard(
                  context,
                  DuringStayPage(),
                  "I'm at the hospital now",
                  Icon(Icons.sick_rounded, color: icons, size: 33)),
              renderClickableSituationCard(
                  context,
                  AfterStayPage(),
                  "I recently visited the hospital",
                  Icon(Icons.medical_services_rounded, color: icons, size: 33)),
              renderClickableSituationCard(
                  context,
                  ReceivedBillPage(),
                  "I've received a surprise medical bill",
                  Icon(Icons.attach_money_rounded, color: icons, size: 37)),
              renderClickableSituationCard(
                  context,
                  CollectionsPage(),
                  "My medical bill/debt has been sent to collections",
                  Icon(Icons.priority_high_rounded, color: icons, size: 33)),
            ],
          ),
        ));
  }
}

class TermsPage extends StatelessWidget {
  TermsPage({this.context, this.rootCategoriesPage});

  final BuildContext? context;
  final RootCategoriesPage? rootCategoriesPage;
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
    return Scaffold(
        backgroundColor: Styles.shadowWhite,
        appBar: AppBar(
          toolbarHeight: 0.0,
          backgroundColor: Styles.modestPink,
        ),
        body: GestureDetector(
          child: ListView(
            children: [
              renderSituationBox(
                  "I want to learn healthcare terms and definitions",
                  Icon(Icons.menu_book_rounded, color: Colors.white, size: 33)),
              // renderGuidelineRichText(
              //     guidelinesTitles[0], subGuidelinesText[0], 1, 0),
              renderGuidelineHyperlink(
                  guidelinesTitles[0],
                  subGuidelinesText[0],
                  hyperlinkHintsText[0],
                  hyperlinks[0],
                  1,
                  0),
              renderGuidelineHyperlink(
                  guidelinesTitles[1],
                  subGuidelinesText[1],
                  hyperlinkHintsText[1],
                  hyperlinks[1],
                  2,
                  0),
              renderGuidelineHyperlink(
                  guidelinesTitles[2],
                  subGuidelinesText[2],
                  hyperlinkHintsText[2],
                  hyperlinks[2],
                  3,
                  0),
              renderGuidelineHyperlink(
                  guidelinesTitles[3],
                  subGuidelinesText[3],
                  hyperlinkHintsText[3],
                  hyperlinks[3],
                  4,
                  0),
              renderGuidelineHyperlink(
                  guidelinesTitles[4],
                  subGuidelinesText[4],
                  hyperlinkHintsText[4],
                  hyperlinks[4],
                  5,
                  0),
              renderGuidelineHyperlink(
                  guidelinesTitles[5],
                  subGuidelinesText[5],
                  hyperlinkHintsText[5],
                  hyperlinks[5],
                  6,
                  0),
              renderGuidelineHyperlink(
                  guidelinesTitles[6],
                  subGuidelinesText[6],
                  hyperlinkHintsText[6],
                  hyperlinks[6],
                  7,
                  0),
              renderGuideline(guidelinesTitles[7], subGuidelinesText[7], 8, 0),
              renderGuidelineHyperlink(
                  guidelinesTitles[8],
                  subGuidelinesText[8],
                  hyperlinkHintsText[7],
                  hyperlinks[7],
                  9,
                  0),
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

class BeforeStayPage extends StatelessWidget {
  BeforeStayPage({this.context, this.rootCategoriesPage});

  final BuildContext? context;
  final RootCategoriesPage? rootCategoriesPage;
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
        backgroundColor: Styles.shadowWhite,
        appBar: AppBar(
          toolbarHeight: 0.0,
          backgroundColor: Styles.modestPink,
        ),
        body: GestureDetector(
          child: ListView(
            children: [
              renderSituationBox("I'm preparing for a hospital visit",
                  Icon(Icons.laptop, color: Colors.white, size: 33)),
              renderGuideline(guidelinesTitles[0], subGuidelinesText[0], 1, 0),
              renderGuideline(guidelinesTitles[1], subGuidelinesText[1], 2, 0),
              renderGuideline(guidelinesTitles[2], subGuidelinesText[2], 3, 0),
              renderGuideline(guidelinesTitles[3], subGuidelinesText[3], 4, 0),
              renderGuideline(guidelinesTitles[4], subGuidelinesText[4], 5, 0),
              renderGuideline(guidelinesTitles[5], subGuidelinesText[5], 6, 0),
              renderGuideline(guidelinesTitles[6], subGuidelinesText[6], 7, 0),
              renderGuideline(guidelinesTitles[7], subGuidelinesText[7], 8, 0),
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

class DuringStayPage extends StatelessWidget {
  DuringStayPage({this.context, this.rootCategoriesPage});

  final BuildContext? context;
  final RootCategoriesPage? rootCategoriesPage;
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
    return Scaffold(
        backgroundColor: Styles.shadowWhite,
        appBar: AppBar(
          toolbarHeight: 0.0,
          backgroundColor: Styles.modestPink,
        ),
        body: GestureDetector(
          child: ListView(
            children: [
              renderSituationBox("I'm at the hospital now",
                  Icon(Icons.sick_rounded, color: Colors.white, size: 33)),
              renderGuideline(guidelinesTitles[0], subGuidelinesText[0], 1, 0),
              renderGuideline(guidelinesTitles[1], subGuidelinesText[1], 2, 0),
              renderGuideline(guidelinesTitles[2], subGuidelinesText[2], 3, 0),
              renderGuideline(guidelinesTitles[3], subGuidelinesText[3], 4, 0),
              renderGuideline(guidelinesTitles[4], subGuidelinesText[4], 5, 0),
              renderGuidelineHyperlink(
                  guidelinesTitles[5],
                  subGuidelinesText[5],
                  hyperlinkHintsText[0],
                  hyperlinks[0],
                  6,
                  0),
              renderGuideline(guidelinesTitles[6], subGuidelinesText[6], 7, 0),
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

class AfterStayPage extends StatelessWidget {
  AfterStayPage({this.context, this.rootCategoriesPage});

  final BuildContext? context;
  final RootCategoriesPage? rootCategoriesPage;
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
    return Scaffold(
        backgroundColor: Styles.shadowWhite,
        appBar: AppBar(
          toolbarHeight: 0.0,
          backgroundColor: Styles.modestPink,
        ),
        body: GestureDetector(
          child: ListView(
            children: [
              renderSituationBox(
                  "I recently visited the hospital",
                  Icon(Icons.medical_services_rounded,
                      color: Colors.white, size: 33)),
              renderGuideline(guidelinesTitles[0], subGuidelinesText[0], 1, 0),
              renderGuideline(guidelinesTitles[1], subGuidelinesText[1], 2, 0),
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
        ));
  }
}

class ReceivedBillPage extends StatelessWidget {
  ReceivedBillPage({this.context, this.rootCategoriesPage});

  final BuildContext? context;
  final RootCategoriesPage? rootCategoriesPage;
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

  final Column guideline4Text =
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      ("Many medical bills sent to patients are confusing and lack sufficient detail for the charges to be well-understood by the patient.\n\nHave a close friend or family member help you write an email (preferred, if possible) or letter to the hospital explaining that you will need more detailed information describing your charges and how they were calculated before you can pay. Try not to worry about sounding professional, just describe what you need from the hospital in simple language.\n\nElements to include in your letter:\n\n(a) Ask in your letter that the billing agency and/or hospital explain to you how each individual charge was determined.\n\n(b) Ask that they provide you with an itemized bill for each date of service they are charging you for.\n\n(c) Once you receive the itemized bill and an explanation of the hospitals charges, you will want to compare this information to the information in your insurance plan’s Explanation of Benefits form.\n\n(d) Ask that they show you evidence that they complied with federal and state pricing laws (in your state).\n\n(e) State that you will pay the correct amount according to your insurance plan’s Explanation of Benefits form after the hospital provides you with all requested information. You may state that it is your right as a consumer to have detailed knowledge about what exactly you are paying for.\n\n(f) Finally, state that you are disputing your bill and that you wish to have your account marked as disputed. State that if your bill is sent to a collections agency, you wish that the hospital/billing agency include a copy of all correspondence between yourself and the hospital, and that the hospital marks your file as disputed." +
          "\n"),
      style: Styles.articleBody.copyWith(color: Colors.black),
    ),
    InkWell(
        child: Text(
          "Source (YouTube Video by DerekVanSchaik)\n\n",
          style: Styles.hyperlink,
        ),
        onTap: () => launch(
            "https://www.youtube.com/watch?v=fo3lvAS96a8&ab_channel=DerekVanSchaik")),
    InkWell(
        child: Text(
          "A template letter (brokenhealthcare.org article) (We recommend adding more from the above mentioned points.)",
          style: Styles.hyperlink,
        ),
        onTap: () =>
            launch("https://brokenhealthcare.org/dispute-every-hospital-bill/"))
  ]);

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
    return Scaffold(
        backgroundColor: Styles.shadowWhite,
        appBar: AppBar(
          toolbarHeight: 0.0,
          backgroundColor: Styles.modestPink,
        ),
        body: GestureDetector(
          child: ListView(
            children: [
              renderSituationBox(
                  "I've received a surprise medical bill",
                  Icon(Icons.attach_money_rounded,
                      color: Colors.white, size: 37)),
              renderGuideline(guidelinesTitles[0], subGuidelinesText[0], 1, 0),
              renderGuideline(guidelinesTitles[1], subGuidelinesText[1], 2, 0),
              renderGuideline(guidelinesTitles[2], subGuidelinesText[2], 3, 0),
              renderGuidelineCustomWidgetText(
                  guidelinesTitles[3], guideline4Text, 4, 0),
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

class CollectionsPage extends StatelessWidget {
  CollectionsPage({this.context, this.rootCategoriesPage});

  final BuildContext? context;
  final RootCategoriesPage? rootCategoriesPage;
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

  final Column guideline3Text =
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      ("You have the right to send a debt validation letter/email to the collection agency under the FDCPA asking them to provide you with evidence that the debt you are being asked to pay is in fact yours." +
          "\n\nIn your letter/email, simply state that you will need to validate the debt before you can pay, and ask for documentation bearing your signature and dates of services you are being billed for. Either send the letter via certified mail or via email, so that you can record the date when the agency receives it." +
          "\n\nWhat you will do next depends on how the agency responds." +
          "\n\n(a) They do not respond within 30 days of receiving your request. If they do not respond, you can file a complaint with the Consumer Financial Protection Bureau "),
      style: Styles.articleBody.copyWith(color: Colors.black),
    ),
    InkWell(
        child: Text(
          "here (consumerfinance.gov complaint submission).\n\n",
          style: Styles.hyperlink,
        ),
        onTap: () => launch(
            "https://www.consumerfinance.gov/complaint/getting-started/")),
    Text(
      "After filing your complaint, send a Failure to Validate letter/email to the collection agency explaining that they have violated your rights as a consumer to have your debt violated, and that you have the right to sue them for damages to your credit score if the debt is not validated, or if the unvalidated debt is not removed from your credit report.",
      style: Styles.articleBody.copyWith(color: Colors.black),
    ),
    InkWell(
        child: Text(
          "\n\nHere is a template Failure to Validate letter (from the achievingcreditexcellence.com blog).",
          style: Styles.hyperlink,
        ),
        onTap: () =>
            launch("https://www.achievingcreditexcellence.com/freebies")),
    Text(
      "\n\n(b) They send you a bill. If they do not send you the explanation of charges and proof that the debt belongs to you, you can also report them to the CFPB and send a Failure to Validate email/letter, because they did not provide sufficient documentation to validate the debt. If they respond within 30 days of receiving your request, do not report them to CFPB yet, but inform them that if they do not send you evidence to validate the debt, you will report them. See (a) and the source blog and video linked below." +
          "\n\n (c) They send you documentation containing your medical records, (information about procedures you received, doctors you were seen by, etc.). If they do this, immediately file a complaint with the Consumer Financial Protection Bureau for violating your rights under HIPAA. You never signed any agreement authorizing them to access your medical records, so if they obtain this information, they have violated your privacy rights under HIPAA. At this point, you have the option to sue them if you wish, but at the very least, they must remove the debt and cease collection of the debt if they have violated your HIPAA rights. Ask the collections agency to delete your private medical information immediately and to cease all collection activities.",
      style: Styles.articleBody.copyWith(color: Colors.black),
    ),
    InkWell(
        child: Text(
          "\n\nSource (from the achievingcreditexcellence.com blog).",
          style: Styles.hyperlink,
        ),
        onTap: () =>
            launch("https://www.achievingcreditexcellence.com/freebies")),
    InkWell(
        child: Text(
          "\n\nSource (YouTube Video explaining how to dispute the debt).",
          style: Styles.hyperlink,
        ),
        onTap: () => launch(
            "https://www.youtube.com/watch?v=3xVGZ4QOCmk&ab_channel=LifeWithMC")),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.shadowWhite,
        appBar: AppBar(
          toolbarHeight: 0.0,
          backgroundColor: Styles.modestPink,
        ),
        body: GestureDetector(
          child: ListView(
            children: [
              renderSituationBox(
                  "My medical bill/debt has been sent to collections",
                  Icon(Icons.priority_high_rounded,
                      color: Colors.white, size: 33)),
              renderGuidelineHyperlink(
                  guidelinesTitles[0],
                  subGuidelinesText[0],
                  hyperlinkHintsText[0],
                  hyperlinks[0],
                  1,
                  0),
              renderGuidelineHyperlink(
                  guidelinesTitles[1],
                  subGuidelinesText[1],
                  hyperlinkHintsText[0],
                  hyperlinks[0],
                  2,
                  0),
              renderGuidelineCustomWidgetText(
                  guidelinesTitles[2], guideline3Text, 3, 0),
              renderGuideline(guidelinesTitles[3], subGuidelinesText[2], 4, 0),
              renderGuidelineHyperlink(
                  guidelinesTitles[4],
                  subGuidelinesText[3],
                  hyperlinkHintsText[0],
                  hyperlinks[0],
                  5,
                  0),
              renderGuidelineHyperlink(
                  guidelinesTitles[5],
                  subGuidelinesText[4],
                  hyperlinkHintsText[0],
                  hyperlinks[0],
                  6,
                  0),
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
