import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:hospital_stay_helper/localizations/language_constants.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expandable/expandable.dart';
import 'package:url_launcher/url_launcher.dart';

// Src: https://medium.com/flutter-community/everything-you-need-to-know-about-flutter-page-route-transition-9ef5c1b32823
// Not using yet:
class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

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

Widget renderClickableSituationCard(
    BuildContext context, pageBuilder, String situation) {
  return GestureDetector(
    child: Padding(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.pinkAccent,
            onPrimary: Colors.white,
          ),
          child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60)),
              title: Text(
                situation,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              )),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    pageBuilder, //context, SlideRightRoute(page: BeforeStayPage())
              )),
        ),
        padding: EdgeInsets.fromLTRB(7, 8, 7, 8)),
  );
}

Widget renderSituationBox(String text) {
  return Padding(
    child: Card(
      child: ListTile(
        title: Text(text,
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ),
      color: Colors.pinkAccent,
    ),
    padding: EdgeInsets.fromLTRB(5, 30, 5, 20),
  );
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          collapsed: Padding(
              child: Text(
                text,
                style: TextStyle(fontSize: 17),
                softWrap: true,
                maxLines: linesShownCollapsed,
                overflow: TextOverflow.ellipsis,
              ),
              padding: EdgeInsets.fromLTRB(4, 12, 4, 4)),
          expanded: Padding(
              child: Text(
                text,
                style: TextStyle(fontSize: 17),
                softWrap: true,
              ),
              padding: EdgeInsets.fromLTRB(4, 12, 4, 4)),
        ),
        padding: EdgeInsets.fromLTRB(8, 15, 8, 15)),
  );
}

// Duplicate that accepts Text() widget:
// Widget renderGuidelineRichText(
//     String title, RichText text, int guidelineNum, int linesShownCollapsed) {
//   return Container(
//     color: Colors.white,
//     child: Padding(
//         child: ExpandablePanel(
//           // theme: ThemeData(backgroundColor: Colors.white),
//           header: Text(
//             "$guidelineNum. " + title,
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//           ),
//           collapsed: Padding(
//             child: Text(
//               text: text,
//             ),
//             padding: EdgeInsets.fromLTRB(4, 12, 4, 4),
//           ),
//           expanded:
//               Padding(child: text, padding: EdgeInsets.fromLTRB(4, 12, 4, 4)),
//         ),
//         padding: EdgeInsets.fromLTRB(8, 15, 8, 15)),
//   );
// }

class RootCategoriesPage extends StatelessWidget {
  RootCategoriesPage({this.context, this.beforeStayPage});

  final BuildContext context;
  final BeforeStayPage beforeStayPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[600],
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              child: Text(
                "Guidelines",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            ),
            Padding(
                child: Card(
                  color: Colors.white,
                  child: Padding(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Learn things you can do before, during and after your hospital visit to help avoid surprise medical bills, and what to do if you recieve one.\n",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            Text(
                              "Start by choosing a category below that best fits your situation.",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ]),
                      padding: EdgeInsets.fromLTRB(15, 11, 15, 11)),
                ),
                padding: EdgeInsets.fromLTRB(0, 12, 0, 12)),
            //renderClickableSituationCard("I'm preparing for a hospital visit"),
            renderClickableSituationCard(context, BeforeStayPage(),
                "I'm preparing for a hospital visit"),
            renderClickableSituationCard(
                context, DuringStayPage(), "I'm at the hospital now"),
            renderClickableSituationCard(
                context, AfterStayPage(), "I recently visited the hospital"),
            renderClickableSituationCard(context, ReceivedBillPage(),
                "I've received a surprise medical bill"),
            renderClickableSituationCard(context, TermsPage(),
                "I want to learn healthcare terms and definitions"),
          ],
        ));
  }
}

class BeforeStayPage extends StatelessWidget {
  BeforeStayPage({this.context, this.rootCategoriesPage});

  final BuildContext context;
  final RootCategoriesPage rootCategoriesPage;
  final List<String> guidelinesTitles = [
    "Make a detailed visit-plan with your provider",
    "Make a list of services/procedures you expect to receive",
    "Make a list of all hospital staff you plan to receive treatment from",
    "Call your insurance provider",
    "Don’t rely on the online information from your insurance provider",
    "Ask for a detailed price estimate of all planned procedures",
  ];
  final List<String> subGuidelinesText = [
    "If you know you have a hospital visit coming up, talk to your doctor or healthcare provider about your upcoming hospital visit. Discuss the guidelines 2, 3 and 4 with your provider and take detailed notes of any information you learn.",
    "Work with your doctor or healthcare provider to make a list of all services, procedures, and health products (casts, blood vials, etc.) you expect to receive during your visit.",
    "Ask your doctor or healthcare provider to help you write a list of all the hospital staff (doctors, surgeons, assistants, etc.) who you believe will be treating you during your stay. Keep this list; it will help you if you receive a surprise bill later on. ",
    "Get your lists from guidelines 2 and 3 ready, then call your insurance provider. Tell them about each test, procedure and service you plan to receive and each hospital staff or doctor you plan to see. Ask them to tell you which services, procedures and hospital staff are in-network (covered by your insurance).",
    "\“Studies have shown that more than half of provider directory information can be incorrect, including the phone number, address, whether the provider is taking patients and who’s considered in-network.\” It is strongly advised to always call your insurance provider before your visit and double check all of your questions with them.",
    "Ask your insurance provider and the hospital administrators for a detailed price estimate of the procedure that you are planning to have.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[600],
        body: GestureDetector(
          child: ListView(
            children: [
              renderSituationBox("I'm preparing for a hospital visit"),
              renderGuideline(guidelinesTitles[0], subGuidelinesText[0], 1, 1),
              renderGuideline(guidelinesTitles[1], subGuidelinesText[1], 2, 1),
              renderGuideline(guidelinesTitles[2], subGuidelinesText[2], 3, 1),
              renderGuideline(guidelinesTitles[3], subGuidelinesText[3], 4, 1),
              renderGuideline(guidelinesTitles[4], subGuidelinesText[4], 5, 1),
              renderGuideline(guidelinesTitles[5], subGuidelinesText[5], 6, 1),
              ElevatedButton(
                  child: Text("Back"), onPressed: () => Navigator.pop(context)),
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

class DuringStayPage extends StatelessWidget {
  DuringStayPage({this.context, this.rootCategoriesPage});

  final BuildContext context;
  final RootCategoriesPage rootCategoriesPage;
  final List<String> guidelinesTitles = [
    "Ask if you will be treated by in-network physicians/providers",
    "Do not pay any portion of a large bill if you do not fully understand the charges",
    "Make a list of every hospital staff member who treats you during your visit",
    "Take detailed notes of everything you learn during your visit",
  ];
  final List<String> subGuidelinesText = [
    "When you arrive to check-in for your appointment, ask the receptionist to double check that all of the providers you will be seeing during your visit are in-network with your insurance.",
    "If you are asked to pay any amount for your treatment while you are at the hospital, ask to see an itemized bill describing each of your charges in detail. Never pay any amount until you fully understand each charge. The best option is to until after you leave the hospital before you pay any amount toward your bill or bills. This is because you may be able to negotiate or dispute the bill by writing a simple letter before you pay.",
    "Write down the names of every hospital staff member who treats you during your visit.",
    "Take detailed notes of any information that you learn from your healthcare providers during your hospital stay, such as if a certain doctor is in-network or out-of network, medical advice given to you by a nurse or a doctor, over the counter treatments you may try, etc. This will not only help you avoid surprise bills, it will also help you manage your health.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[600],
        body: GestureDetector(
          child: ListView(
            children: [
              renderSituationBox("I'm at the hospital now"),
              renderGuideline(guidelinesTitles[0], subGuidelinesText[0], 1, 1),
              renderGuideline(guidelinesTitles[1], subGuidelinesText[1], 2, 1),
              renderGuideline(guidelinesTitles[2], subGuidelinesText[2], 3, 1),
              renderGuideline(guidelinesTitles[3], subGuidelinesText[3], 4, 1),
              ElevatedButton(
                  child: Text("Back"), onPressed: () => Navigator.pop(context))
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

  final BuildContext context;
  final RootCategoriesPage rootCategoriesPage;
  final List<String> guidelinesTitles = [
    "Do not pay any portion of your bill until disputing it",
    "Ask the hospital if they offer any financial assistance",
  ];
  final List<String> subGuidelinesText = [
    "If you have received a large hospital bill, do not pay even a small part of a it until you have tried other methods of handling the bill first. You may be able to write a simple letter from you or your provider to stop collections agencies from contacting you.",
    "Some hospitals, including all non-profit facilities, offer financial assistance to help you pay for your medical bills. Ask the hospital if they offer any of these programs.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[600],
        body: GestureDetector(
          child: ListView(
            children: [
              renderSituationBox("I recently visited the hospital"),
              renderGuideline(guidelinesTitles[0], subGuidelinesText[0], 1, 1),
              renderGuideline(guidelinesTitles[1], subGuidelinesText[1], 2, 1),
              ElevatedButton(
                  child: Text("Back"), onPressed: () => Navigator.pop(context))
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

  final BuildContext context;
  final RootCategoriesPage rootCategoriesPage;
  final List<String> guidelinesTitles = [
    "Write a letter to the hospital disputing the bill"
  ];
  final String titleText = "Write a letter to the hospital disputing the bill";
  final String introduction = '''
  Write a letter to your hospital explaining that you will need more detailed information describing your charges and how they were calculated before you can pay. Try not to worry about sounding professional, just describe what you need from the hospital in simple language.
  \nElements to include in your letter:
  ''';
  final List<String> subGuidelinesText = [
    '''
  (a) Ask in your letter that the billing agency and/or hospital explain to you how each individual charge was determined. Ask for the hospital’s entire price list, which you are entitled to under 42 U.S.C.A. § 300gg-18(e) (you should state this). 
  ''',
    '''
  (b) Ask that they provide you with a copy of your medical treatment record in order to explain each charge.
  ''',
    '''
  (c) If there are any Adjustments or Discounts stated on your bill, ask them to “provide numerical detail” on how these adjustments or discounts were arrived at including price negotiations with your insurance company.”
  ''',
    '''
  (d) Ask that they show you evidence that they complied with federal and state pricing laws (in your state).
  ''',
    '''
  (e) State that you will pay the requested amount after the hospital provides you with the requested information.
  ''',
    '''
  (f) Finally, state that you are disputing your bill and that you wish to have the record of your bill marked as disputed. State that if your bill is sent to a collections agency, you wish that the hospital/billing agency include a copy of all correspondence between yourself and the hospital, and that the hospital marks your file as disputed.
  '''
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[600],
        body: GestureDetector(
          child: ListView(
            children: [
              renderSituationBox("I've received a surprise medical bill"),
              renderGuideline(
                  titleText,
                  (introduction +
                      "\n" +
                      subGuidelinesText[0] +
                      "\n" +
                      subGuidelinesText[1] +
                      "\n" +
                      subGuidelinesText[2] +
                      "\n" +
                      subGuidelinesText[3] +
                      "\n" +
                      subGuidelinesText[4] +
                      "\n" +
                      subGuidelinesText[5]),
                  1,
                  3),
              ElevatedButton(
                  child: Text("Back"), onPressed: () => Navigator.pop(context))
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

class TermsPage extends StatelessWidget {
  TermsPage({this.context, this.rootCategoriesPage});

  final BuildContext context;
  final RootCategoriesPage rootCategoriesPage;
  final List<String> guidelinesTitles = [
    "Provider",
    "Service",
    "Covered Service",
    "In-network provider",
    "Out-of-network provider",
    "Provider Network",
    "Deductible"
  ];
  final List<String> subGuidelinesText = [
    ("\“A healthcare provider is a person or company that provides a healthcare service to you. In other words, your healthcare provider takes care of you.\” \“Provider\” is a very broad term and can refer to your primary care doctor, a physician at an emergency room, the hospital itself, and even your pharmacy." +
        " \n\nSource: " +
        "https://www.verywellhealth.com/what-is-a-provider-1738759"),
    ("A service, as defined in our app, is any healthcare-related product (such as a bandage, a drug, etc.) or service (an appointment with a specialist, a health treatment or therapy, an x-ray, etc.) that a hospital can charge you or your insurance company for."),
    ("\“A healthcare provider’s service or medical supplies covered by your health plan. Benefits will be given for these services based on your plan.\” This means that your insurance has agreed to pay part of the cost for these services." +
        " \n\nSource: " +
        "https://www.medmutual.com/For-Individuals-and-Families/Health-Insurance-Education/Glossary-of-Terms.aspx"),
    ("\“-a health care provider that has a contract with your health insurance plan to provide health care services to its plan members at a pre-negotiated rate. Because of this relationship, you pay a lower cost-sharing when you receive services from an in-network doctor.” It is advised that you receive care only from in-network providers whenever possible because this will greatly reduce the cost of healthcare for you as the patient/consumer." +
        " \n\nSource: " +
        "https://insights.ibx.com/understanding-the-difference-between-in-network-and-out-of-network/"),
    ("\“-a health care provider who does not have a contract with your health insurance plan. If you use an out-of-network provider, health care services could cost more since the provider doesn’t have a pre-negotiated rate with your health plan.\” Out of network bills can be extremely costly, and should be avoided whenever possible." +
        " \n\nSource: " +
        "https://insights.ibx.com/understanding-the-difference-between-in-network-and-out-of-network/"),
    ("\“Most health plans have provider networks. These networks are groups of providers that have agreed to provide services to the health plan’s members at a discounted rate and that have met the quality standards required by your insurer. Your health plan prefers that you use its in-network providers rather than using out-of-network providers.\”" +
        " \n\nSource: " +
        "https://www.verywellhealth.com/what-is-a-provider-1738759"),
    ("The amount you pay for your healthcare services before your health insurer pays. Deductibles are based on your benefit period (typically a year at a time). \nExample: If your plan has a \$2,000 annual deductible, you will be expected to pay the first \$2,000 toward your healthcare services. After you reach \$2,000, your health insurer will cover the rest of the costs." +
        " \n\nSource: " +
        "https://www.medmutual.com/For-Individuals-and-Families/Health-Insurance-Education/Glossary-of-Terms.aspx"),
    // renderClickableLinkPassage(
    //   "\“A healthcare provider is a person or company that provides a healthcare service to you. In other words, your healthcare provider takes care of you.\” \“Provider\” is a very broad term and can refer to your primary care doctor, a physician at an emergency room, the hospital itself, and even your pharmacy.",
    //   " Source",
    //   "https://www.verywellhealth.com/what-is-a-provider-1738759",
    // ),
    // RichText(
    //     text: TextSpan(
    //         text:
    //             "A service, as defined in our app, is any healthcare-related product (such as a bandage, a drug, etc.) or service (an appointment with a specialist, a health treatment or therapy, an x-ray, etc.) that a hospital can charge you or your insurance company for.")),
    // renderClickableLinkPassage(
    //     "\“A healthcare provider’s service or medical supplies covered by your health plan. Benefits will be given for these services based on your plan.\” This means that your insurance has agreed to pay part of the cost for these services.",
    //     " Source",
    //     "https://www.medmutual.com/For-Individuals-and-Families/Health-Insurance-Education/Glossary-of-Terms.aspx"),
    // renderClickableLinkPassage(
    //     "\“-a health care provider that has a contract with your health insurance plan to provide health care services to its plan members at a pre-negotiated rate. Because of this relationship, you pay a lower cost-sharing when you receive services from an in-network doctor.” It is advised that you receive care only from in-network providers whenever possible because this will greatly reduce the cost of healthcare for you as the patient/consumer.",
    //     " Source",
    //     "https://insights.ibx.com/understanding-the-difference-between-in-network-and-out-of-network/"),
    // renderClickableLinkPassage(
    //     "\“-a health care provider who does not have a contract with your health insurance plan. If you use an out-of-network provider, health care services could cost more since the provider doesn’t have a pre-negotiated rate with your health plan.\” Out of network bills can be extremely costly, and should be avoided whenever possible.",
    //     " Source",
    //     "https://insights.ibx.com/understanding-the-difference-between-in-network-and-out-of-network/"),
    // renderClickableLinkPassage(
    //     "\“Most health plans have provider networks. These networks are groups of providers that have agreed to provide services to the health plan’s members at a discounted rate and that have met the quality standards required by your insurer. Your health plan prefers that you use its in-network providers rather than using out-of-network providers.\”",
    //     " Source",
    //     "https://www.verywellhealth.com/what-is-a-provider-1738759"),
    // renderClickableLinkPassage(
    //     "The amount you pay for your healthcare services before your health insurer pays. Deductibles are based on your benefit period (typically a year at a time). \nExample: If your plan has a \$2,000 annual deductible, you will be expected to pay the first \$2,000 toward your healthcare services. After you reach \$2,000, your health insurer will cover the rest of the costs.",
    //     " Source",
    //     "https://www.medmutual.com/For-Individuals-and-Families/Health-Insurance-Education/Glossary-of-Terms.aspx"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[600],
        body: GestureDetector(
          child: ListView(
            children: [
              renderSituationBox(
                  "I want to learn healthcare terms and definitions"),
              renderGuideline(guidelinesTitles[0], subGuidelinesText[0], 1, 2),
              renderGuideline(guidelinesTitles[1], subGuidelinesText[1], 2, 2),
              renderGuideline(guidelinesTitles[2], subGuidelinesText[2], 3, 2),
              renderGuideline(guidelinesTitles[3], subGuidelinesText[3], 4, 2),
              renderGuideline(guidelinesTitles[4], subGuidelinesText[4], 5, 2),
              renderGuideline(guidelinesTitles[5], subGuidelinesText[5], 6, 2),
              renderGuideline(guidelinesTitles[6], subGuidelinesText[6], 7, 2),
              ElevatedButton(
                  child: Text("Back"), onPressed: () => Navigator.pop(context)),
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

// ***DEPRECATED***
class GuidelinesPage extends StatefulWidget {
  GuidelinesPage({Key key}) : super(key: key);
  GuidelinesPageState createState() => new GuidelinesPageState();
}
//************************ */

class GuidelinesPageState extends State<GuidelinesPage>
    with AutomaticKeepAliveClientMixin<GuidelinesPage> {
  SharedPreferences prefs;
  List<String> title, body;
  List<String> beforeStayTitles, beforeStayTexts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Check if user has already read this, and skip to next page

    title = [
      "follow this step",
      "this step is important",
      "this step is optional",
      "Keep in mind that"
    ];
    body = [
      "Explain thisss",
      "This is why",
      "the main reason is",
      "To avoid, we have to... because"
    ];
    beforeStayTitles = [
      "Make a detailed visit-plan with your provider.",
      "Make a list of services/procedures you expect to receive",
      "Make a list of all hospital staff you plan to receive treatment from",
      "Call your insurance provider",
      "Don’t rely on the online information from your insurance provider",
      "Ask for a detailed price estimate of all planned procedures",
    ];
    beforeStayTexts = [
      "If you know you have a hospital visit coming up, talk to your doctor or healthcare provider about your upcoming hospital visit. Discuss the guidelines 2, 3 and 4 with your provider and take detailed notes of any information you learn.",
      "Work with your doctor or healthcare provider to make a list of all services, procedures, and health products (casts, blood vials, etc.) you expect to receive during your visit.",
    ];
  }
  //************************** */

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.pinkAccent,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Colors.pinkAccent,
    );
  }

  List<Slide> getSlide() {
    List<Slide> slides = [
      Slide(
          maxLineTitle: 2,
          backgroundColor: Colors.deepPurple[600],
          title: "Before Hospital",
          styleTitle: TextStyle(
              color: Color(0xff3da4ab),
              fontSize: 30.0,
              fontWeight: FontWeight.bold),
          centerWidget: ListView.builder(
            shrinkWrap: true,
            itemCount: title.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                  child: FocusedMenuHolder(
                    child: ListTile(
                      tileColor: Colors.white,
                      title: Text("Tip number ${title[index]}"),
                    ),
                    blurSize: 5.0,
                    openWithTap: true,
                    onPressed: () {},
                    menuItems: [
                      // ignore: missing_required_param
                      FocusedMenuItem(
                        title: Flexible(
                          child: Text(body[index]),
                        ),
                      )
                    ],
                  ));
            },
          )),
      Slide(
          maxLineTitle: 2,
          backgroundColor: Colors.deepPurple[600],
          title: getTranslated(context, 'during_hospital'),
          styleTitle: TextStyle(
              color: Color(0xff3da4ab),
              fontSize: 30.0,
              fontWeight: FontWeight.bold),
          centerWidget: ListView.builder(
            shrinkWrap: true,
            itemCount: title.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                  child: ListTile(
                    tileColor: Colors.white,
                    title: Text("Tip number ${title[index]}"),
                  ));
            },
          )),
      Slide(
          maxLineTitle: 2,
          backgroundColor: Colors.deepPurple[600],
          title: getTranslated(context, 'after_hospital'),
          styleTitle: TextStyle(
              color: Color(0xff3da4ab),
              fontSize: 30.0,
              fontWeight: FontWeight.bold),
          centerWidget: ListView.builder(
            shrinkWrap: true,
            itemCount: title.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                  child: ListTile(
                    tileColor: Colors.white,
                    title: Text("Tip number ${title[index]}"),
                  ));
            },
          ))
    ];
    return slides;
  }

  Widget renderPreselectedSituationCard(String situation) {
    return Card(
      child: ListTile(title: Text(situation)),
      color: Colors.lightBlue,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.deepPurple[600],
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            child: renderPreselectedSituationCard(
                "I'm preparing for a hospital visit"),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 40),
          ),
          BeforeStayPage(),
        ]),
      ),
    );

    // return IntroSlider(
    //   isShowDotIndicator: true,
    //   slides: getSlide(),
    //   // renderDoneBtn: this.renderDoneBtn(),
    //   renderNextBtn: this.renderNextBtn(),
    //   // renderSkipBtn: this.renderSkipBtn(),
    //   colorSkipBtn: Colors.pinkAccent,
    //   highlightColorSkipBtn: Colors.greenAccent,
    //   colorDot: Colors.pinkAccent,
    //   sizeDot: 10.0,
    //   typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
    // );
  }

  @override
  bool get wantKeepAlive => true;
}
