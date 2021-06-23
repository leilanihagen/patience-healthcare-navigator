import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:hospital_stay_helper/class/sharePref.dart';
import 'package:hospital_stay_helper/config/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String insuranceProvider;

  @override
  void initState() {
    super.initState();
    getInsuranceProvider();
  }

  void getInsuranceProvider() async {
    // setState(() async {
    String temp =
        await MySharedPreferences.instance.getStringValue('user_provider');
    setState(() {
      insuranceProvider = temp;
    });
    // });
  }

  Widget buildWalkthroughCard(String imagePath, String title, String body) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: EdgeInsets.all(10),
      // height: .45.sh,
      // width: 400,
      decoration: BoxDecoration(
          color: HexColor(Styles.lightGreenTheme),
          borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: [
          // Close button:
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    title,
                    style: Styles.articleHeading1,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image:
              SvgPicture.asset(imagePath, height: 100, width: 100
                  // semanticsLabel: 'Avatar image',
                  ),
              // Text:
              Container(
                width: .29.sh,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            body,
                            style: Styles.articleBody,
                            softWrap: true,
                          )),
                    )
                  ],
                ),
              ),
              // Button (optional):
            ],
          ),
        ],
      ),
      // gradient: LinearGradient(
      //     colors: [Colors.white12, HexColor(lightGreenTheme)])),
    );
  }

  Padding buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: Styles.articleHeading1White,
      ),
    );
  }

  Widget buildIconButton(
      Color backgroundColor, Color foregroundColor, Icon icon, String text) {
    return ElevatedButton.icon(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
        onPrimary: foregroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      icon: icon,
      label: Text(
        text,
        style: Styles.buttonTextStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
                // decoration: BoxDecoration(color: Colors.blue),
                child: Column(children: [
              Text('Your provider:'),
              Text(insuranceProvider == null
                  ? 'Tap to select your provider'
                  : insuranceProvider),
            ])),
            buildIconButton(
                Colors.red,
                Colors.white,
                Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                'Call Now')
          ],
        ),
        buildTitle("Welcome to Patience!"),
        buildWalkthroughCard('assets/images/avatar.svg', 'Setup your profile',
            'Get started with Patience by entering some basic information so we can help you better navigate your healthcare (optional). Your data is never shared outside the app.'),
        buildTitle("My Tools"),
      ],
    );
  }
}