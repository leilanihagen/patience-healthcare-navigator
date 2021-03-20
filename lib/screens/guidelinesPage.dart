import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:hospital_stay_helper/localizations/language_constants.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Src: https://medium.com/flutter-community/everything-you-need-to-know-about-flutter-page-route-transition-9ef5c1b32823
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

Widget renderClickableSituationCard(
    BuildContext context, pageBuilder, String situation) {
  GestureDetector(
      child: Card(child: ListTile(title: Text(situation))),
      onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    pageBuilder()), //context, SlideRightRoute(page: BeforeStayPage())
          ));
}

Widget renderGuideline(
    String title, String text, int guidelineNum, int linesShownCollapsed) {
  return Padding(
      child: ExpandablePanel(
        header: Text(
          "$guidelineNum. " + title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        collapsed: Text(
          text,
          style: TextStyle(fontSize: 17),
          softWrap: true,
          maxLines: linesShownCollapsed,
          overflow: TextOverflow.ellipsis,
        ),
        expanded: Text(
          text,
          style: TextStyle(fontSize: 17),
          softWrap: true,
        ),
      ),
      padding: EdgeInsets.fromLTRB(10, 18, 10, 18));
}

class RootCategoriesPage extends StatelessWidget {
  RootCategoriesPage({this.context, this.beforeStayPage});

  final BuildContext context;
  final BeforeStayPage beforeStayPage;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text(
        "Guidelines",
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 30,
            // fontWeight: FontWeight.w300,
            color: Colors.deepPurple),
      ),
      Text(
        "Learn about things you can do before, during and after your hospital visit to help avoid surprise medical bills.",
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 15),
      ),
      //renderClickableSituationCard("I'm preparing for a hospital visit"),
      GestureDetector(
          child: Card(
              child:
                  ListTile(title: Text("I'm preparing for a hospital visit"))),
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BeforeStayPage()), //context, SlideRightRoute(page: BeforeStayPage())
              )),
      GestureDetector(
          child: Card(child: ListTile(title: Text("I'm at the hospital now"))),
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DuringStayPage()), //context, SlideRightRoute(page: BeforeStayPage())
              )),
      GestureDetector(
          child: Card(
              child: ListTile(title: Text("I recently visited the hospital"))),
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AfterStayPage()), //context, SlideRightRoute(page: BeforeStayPage())
              )),
      GestureDetector(
          child: Card(
              child: ListTile(title: Text("I've received a surprise bill"))),
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BeforeStayPage()), //context, SlideRightRoute(page: BeforeStayPage())
              )),
      GestureDetector(
          child: Card(
              child:
                  ListTile(title: Text("I don't have any health insurance"))),
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BeforeStayPage()), //context, SlideRightRoute(page: BeforeStayPage())
              )),
    ]);
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
  final List<String> guidelinesText = [
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
        body: GestureDetector(
      child: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text("I'm preparing for a hospital visit"),
            ),
            color: Colors.lightBlue[100],
          ),
          renderGuideline(guidelinesTitles[0], guidelinesText[0], 1, 1),
          renderGuideline(guidelinesTitles[1], guidelinesText[1], 2, 1),
          renderGuideline(guidelinesTitles[2], guidelinesText[2], 3, 1),
          renderGuideline(guidelinesTitles[3], guidelinesText[3], 4, 1),
          renderGuideline(guidelinesTitles[4], guidelinesText[4], 5, 1),
          renderGuideline(guidelinesTitles[5], guidelinesText[5], 6, 1),
          ElevatedButton(
              child: Text("Back"),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RootCategoriesPage()),
                  )),
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
  final List<String> guidelinesText = [
    "When you arrive to check-in for your appointment, ask the receptionist to double check that all of the providers you will be seeing during your visit are in-network with your insurance.",
    "If you are asked to pay any amount for your treatment while you are at the hospital, ask to see an itemized bill describing each of your charges in detail. Never pay any amount until you fully understand each charge. The best option is to until after you leave the hospital before you pay any amount toward your bill or bills. This is because you may be able to negotiate or dispute the bill by writing a simple letter before you pay.",
    "Write down the names of every hospital staff member who treats you during your visit.",
    "Take detailed notes of any information that you learn from your healthcare providers during your hospital stay, such as if a certain doctor is in-network or out-of network, medical advice given to you by a nurse or a doctor, over the counter treatments you may try, etc. This will not only help you avoid surprise bills, it will also help you manage your health.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      child: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text("I'm preparing for a hospital visit"),
            ),
            color: Colors.lightBlue[100],
          ),
          renderGuideline(guidelinesTitles[0], guidelinesText[0], 1, 1),
          renderGuideline(guidelinesTitles[1], guidelinesText[1], 2, 1),
          renderGuideline(guidelinesTitles[2], guidelinesText[2], 3, 1),
          renderGuideline(guidelinesTitles[3], guidelinesText[3], 4, 1),
          ElevatedButton(
              child: Text("Back"),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RootCategoriesPage()),
                  )),
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
  final List<String> guidelinesText = [
    "If you have received a large hospital bill, do not pay even a small part of a it until you have tried other methods of handling the bill first. You may be able to write a simple letter from you or your provider to stop collections agencies from contacting you.",
    "Some hospitals, including all non-profit facilities, offer financial assistance to help you pay for your medical bills. Ask the hospital if they offer any of these programs.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      child: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text("I'm preparing for a hospital visit"),
            ),
            color: Colors.lightBlue[100],
          ),
          renderGuideline(guidelinesTitles[0], guidelinesText[0], 1, 1),
          renderGuideline(guidelinesTitles[1], guidelinesText[1], 2, 1),
          ElevatedButton(
              child: Text("Back"),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RootCategoriesPage()),
                  )),
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
  final List<String> guidelinesText = [
//     "Write a letter to your hospital explaining that you will need more detailed information describing your charges and how they were calculated before you can pay. Try not to worry about sounding professional, just describe what you need from the hospital in simple language.

// Elements to include in your letter:
// (a) Ask in your letter that the billing agency and/or hospital explain to you how each individual charge was determined. Ask for the hospital\’s entire price list, which you are entitled to under 42 U.S.C.A. § 300gg-18(e) (you should state this).

// (b) Ask that they provide you with a copy of your medical treatment record in order to explain each charge.

// (c) If there are any Adjustments or Discounts stated on your bill, ask them to \“provide numerical detail\” on how these adjustments or discounts were arrived at including price negotiations with your insurance company.\” (https://www.youtube.com/watch?v=fo3lvAS96a8&ab_channel=DerekVanSchaik)

// (d) Ask that they show you evidence that they complied with federal and state pricing laws (in your state).

// (e) State that you will pay the requested amount after the hospital provides you with the requested information.

// (f) Finally, state that you are disputing your bill and that you wish to have the record of your bill marked as disputed. State that if your bill is sent to a collections agency, you wish that the hospital/billing agency include a copy of all correspondence between yourself and the hospital, and that the hospital marks your file as disputed.

// Source: https://www.youtube.com/watch?v=fo3lvAS96a8&ab_channel=DerekVanSchaik

// A resource that provides a template letter to send to a hospital (we recommend adding more points to this letter from the above mentioned points): https://brokenhealthcare.org/dispute-every-hospital-bill/  "
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      child: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text("I'm preparing for a hospital visit"),
            ),
            color: Colors.lightBlue[100],
          ),
          renderGuideline(guidelinesTitles[0], guidelinesText[0], 1, 1),
          renderGuideline(guidelinesTitles[1], guidelinesText[1], 2, 1),
          renderGuideline(guidelinesTitles[2], guidelinesText[2], 3, 1),
          renderGuideline(guidelinesTitles[3], guidelinesText[3], 4, 1),
          renderGuideline(guidelinesTitles[4], guidelinesText[4], 5, 1),
          renderGuideline(guidelinesTitles[5], guidelinesText[5], 6, 1),
          ElevatedButton(
              child: Text("Back"),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RootCategoriesPage()),
                  )),
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

// ***DEPRECATED***
class GuidelinesPageState extends State<GuidelinesPage> {
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
          title: getTranslated(context, 'before_hospital'),
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
    return Column(children: <Widget>[
      Padding(
        child: renderPreselectedSituationCard(
            "I'm preparing for a hospital visit"),
        padding: EdgeInsets.fromLTRB(0, 10, 0, 40),
      ),
      BeforeStayPage(),
    ]);

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
}
