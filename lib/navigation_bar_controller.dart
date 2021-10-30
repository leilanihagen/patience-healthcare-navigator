import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hospital_stay_helper/components/icons.dart';
import 'package:hospital_stay_helper/components/settting_dialog.dart';
import 'package:hospital_stay_helper/config/styles.dart';
import 'package:hospital_stay_helper/plugins/firebase_analytics.dart';
import 'package:hospital_stay_helper/screens/check_hospital.dart';
import 'package:hospital_stay_helper/screens/dashboard.dart';
import 'package:hospital_stay_helper/screens/guidelines_page.dart';
import 'package:hospital_stay_helper/screens/profile_page.dart';
// import 'package:hospital_stay_helper/screens/searchPage.dart';
import 'package:hospital_stay_helper/screens/visits_timeline_page.dart';
import 'screens/guidelines_page.dart';
import 'screens/visits_timeline_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBottomNavBarController extends StatefulWidget {
  final int currentIndex;

  AppBottomNavBarController({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  _AppBottomNavBarControllerState createState() =>
      _AppBottomNavBarControllerState();
}

// (Below) re-implementing the state of AppBottomNavBarController
class _AppBottomNavBarControllerState extends State<AppBottomNavBarController> {
  late List<Widget> pages;
  PageController? _pageController;
  late int _selectedIndex;
  bool haveOpenProfile = false;
  GlobalKey<DashboardPageState> _dashBoardKey = GlobalKey();
  late Box box;
  @override
  void initState() {
    _selectedIndex = widget.currentIndex;
    super.initState();
    observer.analytics.logAppOpen();
    pages = [
      DashboardPage(
        key: _dashBoardKey,
        openPage: openPage,
      ),
      RootCategoriesPage(),
      VisitsTimelinePage(key: PageStorageKey('visitstimeline')),
      HospitalSearchPage(
        key: PageStorageKey('hospitalsearch'),
        openPage: openPage,
      ),
      // SearchPage(key: PageStorageKey('searchservices')),
    ];

    // TODO: If page state lost when changing page in bottom nav bar, then try keepPage = True
    _pageController = PageController(initialPage: _selectedIndex);
    profileSelect();
  }

  profileSelect() async {
    box = await Hive.openBox("mainController");
    // var temp = await MySharedPreferences.instance.getBoolValue("selectProfile");
    var temp = box.get('selectProfile') ?? false;
    setState(() {
      haveOpenProfile = temp;
    });
    if (!temp)
      Future.delayed(
        const Duration(seconds: 3),
        () => showSettingDialog(
          context,
          () {
            Navigator.pop(context);
            Navigator.push(
                    context, MaterialPageRoute(builder: (c) => ProfilePage()))
                .then((_) => _dashBoardKey.currentState!.refresh());
          },
          () => Navigator.pop(context),
        ),
      );
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  void openPage(int index) async {
    setState(() {
      if (0 <= index && index < pages.length) {
        // _selectedIndex = index;
        // _pageController.jumpToPage(index);

        _pageController!.animateToPage(
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
        Navigator.push(
                context, MaterialPageRoute(builder: (c) => ProfilePage()))
            .then((_) => {_dashBoardKey.currentState!.refresh()});
        break;
      default:
    }
  }

  Widget _bottomNavBar(int selectedIndex) => BottomNavigationBar(
          // showSelectedLabels: false,
          // showUnselectedLabels: true,
          // selectedItemColor: Colors.white,
          // unselectedItemColor: Colors.white,
          // backgroundColor: Styles.blueTheme,
          // backgroundColor: Colors.white,

          onTap: (int index) {
            openPage(index);
          },
          // rebuild this widget
          currentIndex: selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CustomIcon.patienceIcon),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.question_answer_outlined,
              ),
              label: 'Guidelines',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.event_note_outlined,
              ),
              label: 'Visits',
            ),
            BottomNavigationBarItem(
              // icon: Icon(Icons.map),
              icon: Icon(
                Icons.location_on_outlined,
              ),
              label: 'Find Hospitals',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.search),
            //   label: 'Services',
            // ),
          ]);

  List<String> _pageTitles = [
    'Dashboard',
    'Guidelines',
    'Visits Timeline',
    'Find In-Network Hospitals',
    // 'Search Medical Services'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Styles.blueTheme,
        // backgroundColor: Colors.white,
        actions: [
          Badge(
            position: BadgePosition.topStart(),
            showBadge: !haveOpenProfile,
            badgeContent: Text(
              "!",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
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
                child: IconButton(
                  iconSize: 35,
                  onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (c) => ProfilePage()))
                      .then((_) => _dashBoardKey.currentState!.refresh()),
                  icon: Icon(Icons.settings),
                ),
              ),
            ),
          ),
        ],
        title: Hero(
          tag: 'app_bar_title',
          child: Material(
            color: Colors.transparent,
            child: Text(
              _pageTitles[_selectedIndex],
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
          // ),
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
