import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:hospital_stay_helper/config/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospital_stay_helper/plugins/firebase_analytics.dart';
import 'package:hospital_stay_helper/provider/navigation_provider.dart';
import 'package:hospital_stay_helper/provider/user_provider.dart';
import 'package:hospital_stay_helper/screens/profile_page.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage>
    with AutomaticKeepAliveClientMixin<DashboardPage> {
  List<bool> walkthrough = [true, true, true, true, true];
  Widget buildWalkthroughCard(String imagePath, String title, String body,
      String buttonText, Gradient gradient, int targetPageIndex) {
    return Visibility(
      visible: walkthrough[targetPageIndex - 1],
      replacement: Align(
        alignment: Alignment.topRight,
        child: ClipOval(
          child: Material(
            color: Styles.blueTheme, // Button color
            child: InkWell(
              splashColor: Colors.red, // Splash color
              onTap: () {
                setState(() {
                  walkthrough[targetPageIndex - 1] = true;
                });
              },
              child: const SizedBox(
                width: 40,
                height: 40,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      child: Stack(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: .03.sw, horizontal: .03.sw),
          child: Card(
            // color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 5,
            child: Container(
              width: .97.sw,
              padding:
                  EdgeInsets.symmetric(vertical: .01.sh, horizontal: .05.sw),
              decoration: BoxDecoration(
                gradient: gradient,
                color: Styles.lightGreenTheme,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  // Title + close button:
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  SizedBox(
                    width: .8.sw,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 0),
                      // alignment: Alignment.topCenter,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: Styles.articleBodyBold
                            .copyWith(color: Colors.black),
                        softWrap: true,
                      ),
                    ),
                  ),
                  // Container(
                  //   width: .1.sw,
                  //   child: Align(
                  //     alignment: Alignment.topRight,
                  //     child: IconButton(
                  //       icon: Icon(Icons.close),
                  //       onPressed: () {},
                  //     ),
                  //   ),
                  // ),
                  //   ],
                  // ),
                  // Text + image:
                  SizedBox(
                      width: .4.sh,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: DropCapText(
                              body,
                              style: Styles.articleBody
                                  .copyWith(color: Colors.black),
                              dropCap: DropCap(
                                height: .33.sw,
                                width: .33.sw,
                                child: // Image:
                                    Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0, 0, .007.sw, .007.sw),
                                  child: Image.asset(imagePath,
                                      height: .33.sw, width: .33.sw),
                                ),
                              ),
                            )),
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: .005.sw),
                    child: TextButton(
                        onPressed: () {
                          Provider.of<MainNavigationProvider>(context)
                              .openPage(targetPageIndex, context);
                        },
                        child: Text(
                          buttonText,
                          style: Styles.medButtonNew,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ClipOval(
            child: Material(
              color: Styles.blueTheme, // Button color
              child: InkWell(
                splashColor: Colors.red, // Splash color
                onTap: () {
                  setState(() {
                    walkthrough[targetPageIndex - 1] = false;
                  });
                },
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }

  Widget buildArticleButton(
      Color color, String title, Image image, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        onTap: () {
          observer.analytics
              .logEvent(name: 'launch_article', parameters: {'url': url});
          launchUrl(Uri.parse(url));
        },
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
              padding: const EdgeInsets.symmetric(vertical: 5),
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

  // Widget buildStatisticButton(Widget impact, String title, String url) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 4.0),
  //     child: GestureDetector(
  //       onTap: () {
  //         observer.analytics.logEvent(
  //             name: 'launch_statistic_article', parameters: {'url': url});
  //         launchUrl(Uri.parse(url));
  //       },
  //       child: Column(
  //         // mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           impact,
  //           // Text(
  //           //   impactText,
  //           //   style: Styles.bigImpact,
  //           // ),
  //           Container(
  //             padding: const EdgeInsets.symmetric(vertical: 5),
  //             width: .25.sh,
  //             child: Text(
  //               title,
  //               style: Styles.articleBodySmall,
  //               softWrap: true,
  //               textAlign: TextAlign.center,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Padding buildTitle(String text, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            //textAlign: TextAlign.left,
            style: Styles.articleHeading1,
          ),
          subtitle == ''
              ? const SizedBox.shrink()
              : Text(
                  subtitle,
                  //textAlign: TextAlign.left,
                  style: Styles.articleBody,
                ),
        ],
      ),
    );
  }

  Widget stateNotSelectedButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: Styles.extraLightPinkTheme),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CustomScrollView(
        slivers: [
          // Header:
          SliverPersistentHeader(
            delegate: CustomSliverDelegate(),
            floating: true,
          ),
          SliverList(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            delegate: SliverChildListDelegate([
              // Header:
              buildTitle("Welcome to Patience!", ''),
              buildWalkthroughCard(
                'assets/images/study_guidelines.png',
                'Learn about healthcare, bills and insurance',
                'Explore healthcare terms and definitions, and learn how to save time and money if you end up at the hospital, receive a surprise medical bill, or if you have medical debt.',
                'Explore Guidelines',
                const LinearGradient(
                  colors: [Styles.extraLightGreen, Styles.medGreenTheme],
                  stops: [.1, .7],
                ),
                1,
              ),
              buildWalkthroughCard(
                'assets/images/setup_settings.png',
                'Setup your user settings',
                'Get started with Patience by entering some basic information so we can help you better navigate your healthcare (optional). Your data is never shared outside the app.',
                'Open User Settings',
                const LinearGradient(
                  colors: [
                    Styles.extraLightPurpleTheme,
                    Styles.lightPurple2Theme
                  ],
                  // begin: Alignment.topLeft,
                  // end: Alignment.bottomRight,
                  stops: [.1, .7],
                ),
                5,
              ),
              // buildTitle("My Tools"),s
              // TO DO (if time): implement simple tracker
              // buildDeductibleTracker(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildTitle("Stay Informed", ''),
                  const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                      child: Icon(Icons.arrow_forward)),
                ],
              ),
              // Articles to external sites:
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildArticleButton(
                      Styles.extraLightPinkTheme,
                      'Find price estimates for medical procedures: MediBid.com',
                      Image.asset(
                        'assets/images/cost_estimate.png',
                      ),
                      'https://www.medibid.com/cost-calculator/',
                    ),
                    buildArticleButton(
                      Styles.grey1,
                      'CostPlus Drug Company is a online pharmacy, by removing the middle man, you can save a lot of money while buying your essential medicine.',
                      Image.asset('assets/images/cost_plus.png'),
                      "https://costplusdrugs.com/",
                    ),
                    buildArticleButton(
                      Styles.lightBlueTheme,
                      'Knowledge is power: more resources on BrokenHealthcare.org',
                      Image.asset(
                        'assets/images/broken_health.png',
                      ),
                      'https://brokenhealthcare.org/patient-education/',
                    ),
                    buildArticleButton(
                      Styles.lightPurpleTheme,
                      'Healthcare laws & regulations in your state',
                      Image.asset(
                        'assets/images/usa.png',
                      ),
                      'https://www.commonwealthfund.org/publications/maps-and-interactives/2021/feb/state-balance-billing-protections',
                    ),
                    buildArticleButton(
                      Styles.shadowWhite,
                      "Clinics offer services for free or at reduced rate",
                      Image.asset(
                        'assets/images/free_clinic.png',
                      ),
                      'https://www.freeclinics.com/',
                    )
                  ],
                ),
              ),
              buildTitle("What Can I Do with Patience?", ''),
              // TODO: add "you can record audio" to the description once this feature is added:
              buildWalkthroughCard(
                'assets/images/medical_records.png',
                'Keep detailed records of your regularly scheduled medical visits',
                'Using our Visits Timeline page, you can keep detailed records of visits with your primary care physician, dentist, physical therapist, you name it! You can take notes and upload photos of documents or other information during your visit, all with automatic timestamps.\n\nKeeping these records not only helps you manage your healthcare for better health outcomes but also helps you track and record your medical bills and expenses. It is especially helpful if you choose to dispute a medical bill.',
                'Explore your Visits Timeline',
                const LinearGradient(
                  colors: [Styles.extraLightPinkTheme, Styles.medPinkTheme],
                  // begin: Alignment.topLeft,
                  // end: Alignment.bottomRight,
                  stops: [.1, .7],
                ),
                2,
              ),
              buildWalkthroughCard(
                'assets/images/find_hospitals.png',
                'Use our Hospital Finder to get to know the in-network hospitals in your area',
                'You never know when an emergency might happen, so it\'s best to be prepared by knowing which hospitals in your area are in-network with your insurance provider. This will help you save critical time and money, and know exactly where to go in an emergency.\n\nWe designed our In-Network Hospital Finder for use in emergency situations, but it is also perfect for preparing for emergencies.\n\nSimply go to the Find Hospitals page and tap "Tap to find/verify hospitals" to see a list of the top 3 in-network hospitals nearby your current location. Tap each hospital name to get directions in Maps.',
                'Explore Find Hospitals',
                const LinearGradient(
                  colors: [Styles.lightEmerald, Styles.emerald],
                  // begin: Alignment.topLeft,
                  // end: Alignment.bottomRight,
                  stops: [.1, .7],
                ),
                3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildTitle("US Healthcare Statistics", '(Tap to read more)'),
                  const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                      child: Icon(Icons.arrow_forward)),
                ],
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 15.0),
              //   child: Text(
              //     'More resources',
              //     style: Styles.articleSubtitleLight,
              //   ),
              // ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StatisticButton(
                          content: 'Up to 4/5 of medical bills contain errors',
                          url:
                              'https://www.hcinnovationgroup.com/finance-revenue-cycle/article/21080693/medical-billing-errors-are-alarmingly-commonand-patients-are-paying-the-price',
                          child: CircularPercentIndicator(
                            animation: true,
                            progressColor: Colors.redAccent,
                            lineWidth: 15,
                            radius: 60,
                            percent: 0.8,
                            center: const Text(
                              "80%",
                              style: Styles.articleBodyBold,
                            ),
                          )),
                      StatisticButton(
                          content:
                              'Of Americans avoid or delay healthcare due to financial barriers',
                          url:
                              'https://www.commonwealthfund.org/publications/issue-briefs/2020/aug/looming-crisis-health-coverage-2020-biennial',
                          child: CircularPercentIndicator(
                            progressColor: Colors.yellow[800],
                            animation: true,
                            lineWidth: 15,
                            radius: 60,
                            percent: 0.35,
                            center: const Text(
                              "35%",
                              style: Styles.articleBodyBold,
                            ),
                          )),
                      StatisticButton(
                          content:
                              'Of Americans avoided healthcare because they were unsure what their insurance covered',
                          url:
                              'https://www.prnewswire.com/news-releases/health-insurance-confusion-is-growing-in-america-policygenius-annual-survey-finds-300945209.html',
                          child: CircularPercentIndicator(
                            progressColor: Styles.dogYellow,
                            lineWidth: 15,
                            radius: 60,
                            percent: 0.272,
                            center: const Text(
                              "27.2%",
                              style: Styles.articleBodyBold,
                            ),
                          )),
                      const StatisticButton(
                          content:
                              'We spend avg. 2× as much as other developed nations on healthcare',
                          url: 'https://youtu.be/tNla9nyRMmQ',
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 19,
                            ),
                            child: Text('2×', style: Styles.bigImpact),
                          )),
                      StatisticButton(
                          content:
                              'Higher disease burden (measure of health outcome) than other developed nations',
                          url:
                              'https://www.healthsystemtracker.org/chart-collection/quality-u-s-healthcare-system-compare-countries/#item-age-standardized-disability-adjusted-life-year-daly-rate-per-100000-population-2017',
                          child: CircularPercentIndicator(
                            progressColor: Styles.dogYellow,
                            lineWidth: 15,
                            radius: 60,
                            percent: 0.31,
                            center: const Text(
                              "31%",
                              style: Styles.articleBodyBold,
                            ),
                          )),
                    ]),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

/// Small helper ChangeNotifier just to manually trigger a rebuild (when height changes)
class _Rebuild extends ChangeNotifier {}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  double height = 400;
  CustomSliverDelegate();

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return ChangeNotifierProvider(
      create: (_) => _Rebuild(),
      child: LayoutBuilder(
        builder: (c, cd) {
          c.watch<_Rebuild>();
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if (c.size != null && height != c.size!.height) {
              height = c.size!.height;
              c.read<_Rebuild>().notifyListeners();
            }
          });

          return Container(
            padding: EdgeInsets.symmetric(vertical: .02.sh),
            decoration: BoxDecoration(
              color: (Theme.of(context).brightness == Brightness.dark)
                  ? Colors.grey[850]
                  : Styles.purpleTheme,
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(.1.sw),
                bottomRight: Radius.circular(.1.sw),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, .20),
                  child: Text(
                    'Your Information',
                    style: Styles.articleBodyBold.copyWith(color: Colors.white),
                  ),
                ),
                Consumer<UserProvider>(
                  builder: (context, model, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Insurance provider disp:
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 5),
                          margin: const EdgeInsets.fromLTRB(15, 4, 5, 4),
                          decoration: BoxDecoration(
                              color: Styles.darkerBlueTheme,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/profile'),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Insurance:',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16)),
                                      ),
                                      Text(
                                          model.insuranceProvider == ''
                                              ? 'Tap to choose'
                                              : model.insuranceProvider!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                    ]),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(3, 0, 0, 0),
                                  child: ElevatedButton.icon(
                                    onPressed: () => model.callPRovider(),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      onPrimary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      "Call",
                                      style: Styles.buttonTextStyle,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        // State disp:
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => const ProfilePage())),
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Styles.modestPink),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: model.state == ''
                                  ? const Text(
                                      'Select\n state',
                                      textAlign: TextAlign.center,
                                      style: Styles.medButtonWhite,
                                    )
                                  : Text(
                                      model.state!,
                                      textAlign: TextAlign.center,
                                      style: Styles.largeButtonWhite,
                                    ),
                            ),
                          ),
                        )
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
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  // TODO: If something doesn't work in the future, try returning true
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}

class StatisticButton extends StatelessWidget {
  final Widget child;
  final String content, url;
  const StatisticButton(
      {Key? key, required this.child, this.content = "", this.url = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        onTap: () {
          observer.analytics.logEvent(
              name: 'launch_statistic_article', parameters: {'url': url});
          launchUrl(Uri.parse(url));
        },
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            child,
            // Text(
            //   impactText,
            //   style: Styles.bigImpact,
            // ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: .25.sh,
              child: Text(
                content,
                style: Styles.articleBodySmall,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
