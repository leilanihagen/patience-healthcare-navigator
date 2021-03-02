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

class GuidelinesPage extends StatefulWidget {
  GuidelinesPage({Key key}) : super(key: key);
  GuidelinesPageState createState() => new GuidelinesPageState();
}

class GuidelinesPageState extends State<GuidelinesPage> {
  SharedPreferences prefs;
  List<String> title, body;

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IntroSlider(
      isShowDotIndicator: true,
      slides: getSlide(),
      // renderDoneBtn: this.renderDoneBtn(),
      renderNextBtn: this.renderNextBtn(),
      // renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: Colors.pinkAccent,
      highlightColorSkipBtn: Colors.greenAccent,
      colorDot: Colors.pinkAccent,
      sizeDot: 10.0,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
    );
  }
}
