import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:hospital_stay_helper/class/sharePref.dart';
import 'package:hospital_stay_helper/components/tapEditBoxNumeric.dart';
import 'package:hospital_stay_helper/config/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospital_stay_helper/navigation_bar_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String insuranceProvider, stateOfResidence;
  // double amountDeductiblePaid;

  // _loadSaved() async {
  //   double temp = await MySharedPreferences.instance
  //       .getDoubleValue('user_deductible_paid');
  //   print(temp);
  //   setState(() {
  //     amountDeductiblePaid = temp;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // _loadSaved();
    getInsuranceProvider();
    getStateOfResidence();
  }

  // void updateAmountDeductiblePaid(num updatedAmount) {
  //   setState(() {
  //     amountDeductiblePaid = updatedAmount;
  //   });
  //   MySharedPreferences.instance
  //       .setDoubleValue('user_deductible_paid', amountDeductiblePaid);
  // }

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

  Widget buildWalkthroughCard(String imagePath, String title, String body,
      String buttonText, Gradient gradient, int targetPageIndex) {
    return Container(
      width: .9.sw,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: .01.sh, horizontal: .05.sw),
      decoration: BoxDecoration(
          gradient: gradient,
          color: Styles.lightGreenTheme,
          borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: [
          // Title + close button:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: .7.sw,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      title,
                      style: Styles.articleHeading1,
                      softWrap: true,
                    ),
                  ),
                ),
              ),
              Container(
                width: .1.sw,
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          // Text + image:
          Container(
              width: .4.sh,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: DropCapText(
                      body,
                      style: Styles.articleBody,
                      dropCap: DropCap(
                        height: .33.sw,
                        width: .33.sw,
                        child: // Image:
                            Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, .007.sw, .007.sw),
                          child: Image.asset(imagePath,
                              height: .33.sw, width: .33.sw),
                        ),
                      ),
                    )),
              )),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AppBottomNavBarController(
                            currentIndex: targetPageIndex)));
              },
              child: Text(
                buttonText,
                style: Styles.medButtonWhite,
              )),
        ],
      ),
    );
  }

  Widget buildArticleButton(
      Color color, String title, Image image, String url) {
    return GestureDetector(
      onTap: () => launch(url),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            height: .15.sh,
            width: .15.sh,
            child: image,
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
      ),
    );
  }

  // Widget buildDeductibleTracker() {
  //   return Container(
  //       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
  //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
  //       width: .9.sw,
  //       decoration: BoxDecoration(
  //           color: Styles.darkGreenTheme,
  //           borderRadius: BorderRadius.circular(5.0)),
  //       child: Column(
  //         children: [
  //           // Remaining/total annual:

  //           // View annual deductible:

  //           // Edit amount paid:
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Container(
  //                 width: .3.sw,
  //                 child: Text(
  //                   'Amount paid:',
  //                   style: Styles.articleBodyBold,
  //                 ),
  //               ),
  //               Container(
  //                 width: .5.sw,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: [
  //                     Container(
  //                       width: .05.sw,
  //                       child: Text(
  //                         '\$',
  //                         style: TextStyle(
  //                             fontSize: 22, fontWeight: FontWeight.w800),
  //                       ),
  //                     ),
  //                     TapEditBoxNumeric(
  //                       height: 30,
  //                       width: .4.sw,
  //                       inputData: amountDeductiblePaid,
  //                       updateFunction: updateAmountDeductiblePaid,
  //                       defaultText: 'Enter amount',
  //                       textStyle: Styles.articleBody,
  //                       shouldWrap: true,
  //                       keyboardType: TextInputType.number,
  //                       boxDecoration: BoxDecoration(
  //                           color: Colors.white,
  //                           borderRadius: BorderRadius.circular(8.0)),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           )
  //         ],
  //       ));
  // }

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
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Styles.darkOrange),
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
      body: Column(
        children: [
          // Header:
          Container(
            padding: EdgeInsets.symmetric(vertical: .02.sh),
            decoration: BoxDecoration(
              color: Styles.purpleTheme,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(.1.sw),
                bottomRight: Radius.circular(.1.sw),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, .015.sw),
                  child: Text('Your Information',
                      style: Styles.articleHeading1White),
                ),
                // Provider + state text hints:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Padding(
                    //   padding: EdgeInsets.fromLTRB(0, 10, 100, 0),
                    //   child: Text('Your state:',
                    //       style:
                    //           TextStyle(color: Colors.white, fontSize: 16)),
                    // ),
                  ],
                ),
                // Ins. provider + state displays:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Insurance provider disp:
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                      margin: EdgeInsets.fromLTRB(15, 4, 5, 10),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text('Insurance:',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                ),
                                Text(
                                    insuranceProvider == null
                                        ? 'Tap to choose'
                                        : insuranceProvider,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header:
                  buildTitle("Welcome to Patience!"),
                  buildWalkthroughCard(
                      'assets/images/study_guidelines.png',
                      'Learn about healthcare, bills and insurance',
                      'Tap to explore healthcare terms and definitions, and learn how to save time and money if you end up at the hospital, receive a surprise medical bill, or if you have medical debt.',
                      'Tap to explore Guidelines',
                      LinearGradient(
                        colors: [
                          Styles.extraLightGreen,
                          Styles.lightGreenTheme
                        ],
                        stops: [.1, .7],
                      ),
                      1),
                  buildWalkthroughCard(
                      'assets/images/setup_settings.png',
                      'Setup your user settings',
                      'Get started with Patience by entering some basic information so we can help you better navigate your healthcare (optional). Your data is never shared outside the app.',
                      'Tap to open User Settings',
                      LinearGradient(
                        colors: [
                          Styles.extraLightPurpleTheme,
                          Styles.lightPurple2Theme
                        ],
                        // begin: Alignment.topLeft,
                        // end: Alignment.bottomRight,
                        stops: [.1, .7],
                      ),
                      5),
                  // buildTitle("My Tools"),s
                  // TO DO (if time): implement simple tracker
                  // buildDeductibleTracker(),
                  buildTitle("Stay Informed"),
                  // Articles to external sites:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildArticleButton(
                        Styles.lightPurpleTheme,
                        'Healthcare laws & regulations in your state',
                        Image.asset(
                          'assets/images/usa.png',
                          height: .12.sh,
                          width: .12.sh,
                        ),
                        'https://www.commonwealthfund.org/publications/maps-and-interactives/2021/feb/state-balance-billing-protections',
                      ),
                      buildArticleButton(
                        Styles.lightBlueTheme,
                        'Knowledge is power: more resources on BrokenHealthcare.org',
                        Image.asset(
                          'assets/images/broken_health.png',
                          height: .12.sh,
                          width: .12.sh,
                        ),
                        'https://brokenhealthcare.org/patient-education/',
                      ),
                    ],
                  ),
                  buildTitle("What Can I Do with Patience?"),
                  buildWalkthroughCard(
                      'assets/images/medical_records.png',
                      'Keep detailed records of your regularly scheduled medical visits',
                      'Using our Visits Timeline page, you can keep detailed records of visits with your primary care physician, dentist, physical therapist, you name it! You can take notes during your visit including uploading photos and recording audio.\n\nKeeping these records not only helps you manage your healthcare for better health outcomes but also helps you track and record your medical bills and expenses. It is especially helpful if you choose to dispute a medical bill.',
                      'Tap to explore your Visits Timeline',
                      LinearGradient(
                        colors: [
                          Styles.extraLightGreen,
                          Styles.lightGreenTheme
                        ],
                        // begin: Alignment.topLeft,
                        // end: Alignment.bottomRight,
                        stops: [.1, .7],
                      ),
                      2),
                  buildWalkthroughCard(
                      'assets/images/find_hospitals.png',
                      'Use our Hospital Finder to get to know the in-network hospitals in your area',
                      'You never know when an emergency might happen, so it\'s best to be prepared by knowing which hospitals in your area are in-network with your insurance provider. This will help you save critical time and money, and know exactly where to go in an emergency.\n\nWe designed our In-Network Hospital Finder for use in emergency situations, but it is also perfect for preparing for emergencies.\n\nSimply go to the Find Hospitals page and tap "Find In-Network Hospitals" to see a list of the top 3 in-network hospitals nearby your current location. Tap each hospital name to get directions in Maps.',
                      'Tap to explore Find Hospitals',
                      LinearGradient(
                        colors: [
                          Styles.extraLightGreen,
                          Styles.lightGreenTheme
                        ],
                        // begin: Alignment.topLeft,
                        // end: Alignment.bottomRight,
                        stops: [.1, .7],
                      ),
                      3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
