import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:hospital_stay_helper/class/sharePref.dart';
import 'package:hospital_stay_helper/components/tapEditBox.dart';
import 'package:hospital_stay_helper/components/visitTapEditBox.dart';
import 'package:hospital_stay_helper/config/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String insuranceProvider, stateOfResidence;
  double amountDeductiblePaid;

  _loadSaved() async {
    double temp = await MySharedPreferences.instance
        .getDoubleValue('user_deductible_paid');
    setState(() {
      amountDeductiblePaid = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSaved();
    getInsuranceProvider();
    getStateOfResidence();
  }

  void updateAmountDeductiblePaid(double updatedAmount) {
    setState(() {
      amountDeductiblePaid = updatedAmount;
    });
    MySharedPreferences.instance
        .setDoubleValue('user_deductible_paid', amountDeductiblePaid);
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

  void getStateOfResidence() async {
    // setState(() async {
    String temp =
        await MySharedPreferences.instance.getStringValue('user_state');
    setState(() {
      stateOfResidence = temp;
    });
    // });
  }

  Widget buildWalkthroughCard(String imagePath, String title, String body) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [Colors.white, Styles.lightGreenTheme],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   stops: [.1, .5],
          // ),
          color: Styles.lightGreenTheme,
          borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: [
          // Close button:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }

  Widget buildArticleButton(Color color, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          height: .15.sh,
          width: .15.sh,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          width: .25.sh,
          child: Text(
            title,
            style: Styles.articleBodySmall,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget buildDeductibleTracker() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        width: .9.sw,
        decoration: BoxDecoration(
            color: Styles.darkGreenTheme,
            borderRadius: BorderRadius.circular(5.0)),
        child: Column(
          children: [
            // Remaining/total annual:

            // View annual deductible:

            // Edit amount paid:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: .3.sw,
                  child: Text(
                    'Amount paid:',
                    style: Styles.articleBodyBold,
                  ),
                ),
                Container(
                  width: .5.sw,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: .05.sw,
                        child: Text(
                          '\$',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w800),
                        ),
                      ),
                      TapEditBox(
                        height: 30,
                        width: .4.sw,
                        inputData: amountDeductiblePaid,
                        updateFunction: updateAmountDeductiblePaid,
                        defaultText: 'Enter amount',
                        textStyle: Styles.articleBody,
                        shouldWrap: true,
                        keyboardType: TextInputType.number,
                        boxDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0)),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }

  Padding buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: Styles.articleHeading1,
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

  Widget stateNotSelectedButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Styles.lightPinkTheme),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(
                'assets/images/nostate.png',
                height: 80,
                width: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStateButton() {
    // String image = '';
    // switch (stateOfResidence) {
    //   case 'WA':
    //     image = 'wa.png';
    //     break;
    //   case 'OR':
    //     image = 'or.png';
    //     break;
    //   case 'CA':
    //     image = 'ca.png';
    //     break;
    //   case 'MD':
    //     image = 'md.png';
    //     break;
    //   case 'VA':
    //     image = 'va.png';
    //     break;
    //   case 'DC':
    //     image = 'dc.png';
    //     break;
    //   case 'GA':
    //     image = 'ga.png';
    //     break;
    //   default:
    //     image = 'nostate.png';
    // }

    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 7, 0, 0),
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Styles.darkPinkTheme),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: stateOfResidence == null
              ? Text(
                  'Select\n state',
                  textAlign: TextAlign.center,
                  style: Styles.smallButtonWhite,
                )
              : Text(
                  stateOfResidence,
                  textAlign: TextAlign.center,
                  style: Styles.largeButtonWhite,
                ),
          // Column(
          //   children: [
          //     // Image.asset(
          //     //   'assets/images/' + image,
          //     //   height: 80,
          //     //   width: 50,
          //     // ),
          //   ],
          // ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Provider + state text hints:
            Container(
              decoration: BoxDecoration(color: Styles.purpleTheme),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                        child: Text('Your provider:',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 100, 0),
                        child: Text('Your state:',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ],
                  ),
                  // Ins. provider + state displays:
                  Row(
                    children: [
                      // Insurance provider disp:
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                        margin: EdgeInsets.fromLTRB(15, 4, 5, 10),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Row(
                          children: [
                            Column(children: [
                              Text(
                                  insuranceProvider == null
                                      ? 'Tap to choose'
                                      : insuranceProvider,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700)),
                            ]),
                            Padding(
                              padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                              child: buildIconButton(
                                  Colors.red,
                                  Colors.white,
                                  Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  ),
                                  'Call'),
                            )
                          ],
                        ),
                      ),
                      // State disp:
                      buildStateButton(),
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                      //   margin: EdgeInsets.fromLTRB(3, 10, 15, 10),
                      //   decoration: BoxDecoration(
                      //       color: Colors.green,
                      //       borderRadius: BorderRadius.circular(10.0)),
                      //   child: Column(children: [
                      //     Text('Your state:',
                      //         style: TextStyle(color: Colors.white, fontSize: 16)),
                      //     Text(
                      //         stateOfResidence == null
                      //             ? 'Tap to choose'
                      //             : stateOfResidence,
                      //         style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 17,
                      //             fontWeight: FontWeight.w700)),
                      //   ]),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            buildTitle("Welcome to Patience!"),
            buildWalkthroughCard(
                'assets/images/avatar.svg',
                'Setup your profile',
                'Get started with Patience by entering some basic information so we can help you better navigate your healthcare (optional). Your data is never shared outside the app.'),
            buildTitle("My Tools"),
            // TO DO (if time): implement simple tracker
            // buildDeductibleTracker(),
            buildTitle("Stay Informed"),
            // Articles to external sites:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildArticleButton(Styles.lightGreenTheme,
                    'Healthcare laws & regulations in your state'),
                buildArticleButton(Styles.darkGreenTheme,
                    'Knowledge is power: more resources on BrokenHealthcare.org'),
              ],
            ),
            buildWalkthroughCard(
                'assets/images/avatar.svg',
                'Learn about healthcare, bills and insurance',
                'Tap to explore healthcare terms and definitions, and learn how to save time and money if you end up at the hospital, receive a surprise medical bill, or if you have medical debt.'),
          ],
        ),
      ),
    );
  }
}
