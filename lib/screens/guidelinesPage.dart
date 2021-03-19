import 'dart:html';

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

class RootCategoriesPage extends StatelessWidget {
  RootCategoriesPage({this.context, this.beforeStayPage});

  final BuildContext context;
  final BeforeStayPage beforeStayPage;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text(
        "Guidelines",
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w300,
            color: Colors.deepPurple),
      ),
      Text(
          "Learn about things you can do before, during and after your hospital visit to help avoid surprise medical bills."),
      //renderClickableSituationCard("I'm preparing for a hospital visit"),
      GestureDetector(
        child: Card(
            child: ListTile(title: Text("I'm preparing for a hospital visit"))),
        onTap: Navigator.push(MaterialPageRoute(
            builder: (context) =>
                BeforeStayPage())), //context, SlideRightRoute(page: BeforeStayPage())
      )
    ]);
  }
}

class BeforeStayPage extends StatelessWidget {
  BeforeStayPage({this.context, this.rootCategoriesPage});

  final BuildContext context;
  final RootCategoriesPage rootCategoriesPage;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FocusedMenuHolder(
            child: Card(
              child: ListTile(
                title: Text("Make a detailed visit-plan with your provider."),
                subtitle: Text(
                    "If you know you have a hospital visit coming up, talk to your doctor or healthcare provider about your upcoming hospital visit. Discuss the guidelines 2, 3 and 4 with your provider and take detailed notes of any information you learn."),
              ),
            ),
            onPressed: () {},
            menuItems: <FocusedMenuItem>[
              FocusedMenuItem(
                title: Text(
                    "If you know you have a hospital visit coming up, talk to your doctor or healthcare provider about your upcoming hospital visit. Discuss the guidelines 2, 3 and 4 with your provider and take detailed notes of any information you learn."),
                onPressed: () {},
              )
            ]),
        Card(
          child: ListTile(
            title: Text(
                "Make a list of services/procedures you expect to receive"),
            subtitle: Text(
                "Work with your doctor or healthcare provider to make a list of all services, procedures, and health products (casts, blood vials, etc.) you expect to receive during your visit."),
          ),
        ),
      ],
    );
  }
}

// ***DEPRECATED***
class GuidelinesPage extends StatefulWidget {
  GuidelinesPage({Key key}) : super(key: key);
  GuidelinesPageState createState() => new GuidelinesPageState();
}

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

  Widget renderClickableSituationCard(String situation) {
    // GestureDetector(
    //    onTap:
    //    child:
    Card(
      child: ListTile(title: Text(situation)),
    );
    //);
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
