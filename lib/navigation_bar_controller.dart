import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hospital_stay_helper/class/sharePref.dart';
import 'package:hospital_stay_helper/config/styles.dart';
import 'package:hospital_stay_helper/plugins/firebase_analytics.dart';
import 'package:hospital_stay_helper/screens/checkHospital.dart';
import 'package:hospital_stay_helper/screens/dashboard.dart';
import 'package:hospital_stay_helper/screens/guidelinesPage.dart';
import 'package:hospital_stay_helper/screens/profilePage.dart';
import 'package:hospital_stay_helper/screens/searchPage.dart';
import 'package:hospital_stay_helper/screens/visitsTimelinePage.dart';
import 'screens/guidelinesPage.dart';
import 'screens/visitsTimelinePage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBottomNavBarController extends StatefulWidget {
  final int currentIndex;

  AppBottomNavBarController({Key key, @required this.currentIndex})
      : super(key: key);

  @override
  _AppBottomNavBarControllerState createState() =>
      _AppBottomNavBarControllerState();
}

// (Below) re-implementing the state of AppBottomNavBarController
class _AppBottomNavBarControllerState extends State<AppBottomNavBarController> {
  List<Widget> pages;
  PageController _pageController;
  int _selectedIndex;
  bool haveOpenProfile = false;

  @override
  void initState() {
    _selectedIndex = widget.currentIndex;
    super.initState();
    observer.analytics.logAppOpen();
    pages = [
      DashboardPage(
        key: PageStorageKey('dashboard'),
        openPage: openPage,
      ),
      RootCategoriesPage(),
      VisitsTimelinePage(key: PageStorageKey('visitstimeline')),
      HospitalSearchPage(
        key: PageStorageKey('hospitalsearch'),
        openPage: openPage,
      ),
      SearchPage(key: PageStorageKey('searchservices')),
    ];

    // TODO: If page state lost when changing page in bottom nav bar, then try keepPage = True
    _pageController = PageController(initialPage: _selectedIndex);
    profileSelect();
  }

  profileSelect() async {
    var temp = await MySharedPreferences.instance.getBoolValue("selectProfile");
    setState(() {
      haveOpenProfile = temp;
    });
    if (!temp)
      Future.delayed(
          const Duration(seconds: 3),
          () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.all(0),
                  elevation: 10,
                  title: Text("Set your profile at User Settings"),
                  content: Image.asset(
                    'assets/images/setup_settings_crop.png',
                    width: .30.sw,
                    height: .30.sw,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Later")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) => ProfilePage()));
                        },
                        child: Text("Okay")),
                  ],
                );
              }));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void openPage(int index) async {
    setState(() {
      if (0 <= index && index < pages.length) {
        // _selectedIndex = index;
        // _pageController.jumpToPage(index);

        _pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 800),
          // Stick with Curves.easeIn or similar to avoid errors (https://github.com/flutter/flutter/issues/47730)
          curve: Curves.ease,
        );
      }
    });
    switch (index) {
      case 0:
        observer.analytics.logEvent(name: 'open_dashboard');

        break;
      case 1:
        observer.analytics.logEvent(name: 'open_guildelines');
        break;
      case 2:
        observer.analytics.logEvent(name: 'open_visittimeline');

        break;
      case 3:
        observer.analytics.logEvent(name: 'open_checkhospital');
        break;
      case 4:
        observer.analytics.logEvent(name: 'open_searchpage');
        break;
      case 5:
        observer.analytics.logEvent(name: 'open_profilepage');
        break;
      default:
    }
  }

  Widget _bottomNavBar(int selectedIndex) => Theme(
        data: Theme.of(context).copyWith(canvasColor: Styles.blueTheme),
        child: BottomNavigationBar(
            // showSelectedLabels: false,
            // showUnselectedLabels: true,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            backgroundColor: Styles.blueTheme,
            selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w700, color: Styles.darkPinkTheme),
            onTap: (int index) {
              setState(() => openPage(index));
            },
            // rebuild this widget
            currentIndex: selectedIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconData(
                  62421,
                  fontFamily: 'MaterialIcons',
                )),
                label: 'Guidelines',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.event_note,
                ),
                label: 'Visits',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconData(0xe857, fontFamily: 'MaterialIcons')),
                label: 'Find Hospitals',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconData(59828, fontFamily: 'MaterialIcons')),
                label: 'Services',
              ),
            ]),
      );

  List<String> _pageTitles = [
    'Dashboard',
    'Guidelines',
    'Visits Timeline',
    'Find In-Network Hospitals',
    'Search Medical Services'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.blueTheme,
        actions: [
          Badge(
            position: BadgePosition.topStart(),
            // badgeColor: Colors.white,
            showBadge: !haveOpenProfile,
            badgeContent: Text(
              "1",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
            child: Hero(
              tag: 'settings_icon',

              // Not doing the flightShuttleBuilder approach to have the left arrow rotation animation
              // This is because the duration is too less, so the animation won't even be seen.
              // Thus, no point in increasing complexity that'll decrease performance
              // So sticking only with the usual Hero animation (no rotation animation)

              // flightShuttleBuilder: (context, anim, dir, _, __) {
              //   print(anim.value);
              //   ColorTween tween = ColorTween(begin: Colors.red, end: Colors.green);
              //   return Container(width: 20.0 * anim.value, height: 20.0, color: tween.transform(anim.value),);
              // },
              // flightShuttleBuilder: (
              //     BuildContext flightContext,
              //     Animation<double> animation,
              //     HeroFlightDirection flightDirection,
              //     BuildContext fromHeroContext,
              //     BuildContext toHeroContext,
              //     ) {
              //   print(animation.value);
              //   final Hero toHero = toHeroContext.widget;
              //   return RotationTransition(
              //     turns: animation,
              //     child: toHero.child,
              //   );
              // },
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 48.0,
                  height: 48.0,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (c) => ProfilePage())),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Icon(
                          Icons.settings,
                          color: Colors.grey,
                          size: 24.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        title: Hero(
          tag: 'app_bar_title',
          child: Container(
            width: double.infinity,
            child: Material(
              color: Colors.transparent,
              child: Text(
                _pageTitles[_selectedIndex],
                style: Styles.appBar,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavBar(_selectedIndex),
      body: PageView(
        controller: _pageController,
        // physics: NeverScrollableScrollPhysics(),
        // physics: BouncingScrollPhysics(),
        children: pages,
        onPageChanged: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
